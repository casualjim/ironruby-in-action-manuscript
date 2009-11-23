#### End goal

# filesystem do
#   watch("/path/to/watch", /_spec.rb$/ui) do
#     on_change { |args| # do stuff here with args.path or args.name }
#     on_change /integration\/.*_spec.rb/ { |args| # do stuff here with args.path or args.name } 
#     on_rename { |args| # do stuff here with args.path, args.name, args.old_path or args.old_name }
#     on_rename "*.rb" { |args| # do stuff here with args.path, args.name, args.old_path or args.old_name } 
#     on_delete { |args| # do stuff here with args.path or args.name } 
#     on_create { |args| # do stuff here with args.path or args.name } 
#     on_error  { |args| # do stuff here with args.path or args.name } 
#   end
#   watch("/another/path/to/watch", /app\/.*\.rb$/ui) do
#     on_change { |args| # do stuff here with args.path or args.name } 
#     on_rename { |args| # do stuff here with args.path, args.name, args.old_path or args.old_name } 
#     on_delete { |args| # do stuff here with args.path or args.name } 
#     on_create { |args| # do stuff here with args.path or args.name } 
#     on_error  { |args| # do stuff here with args.path or args.name } 
#   end
# end

raise "This library requires the .NET framework so you need IronRuby" unless defined? IRONRUBY_VERSION

require 'System'

class String
  
  alias :old_gsub :gsub
  def gsub(pattern, replacement=nil, &b)
    if pattern.is_a? Hash
      pattern.inject(self.dup) { |memo, k, v| memo.old_gsub k, v }
    else
      old_gsub(pattern, replacement, &b)
    end
  end
  
  def to_watcher_guard
    re_str = self.gsub /(\/)/ => '\/',                # normalize \\ on windows to /
                       /\./ => '\.',                  # replace . with an escaped \.
                       /\?/ => '.?',                  # replace ? with an optional charachter .?
                       /\*/ => ".*",                  # replace * with .* for wildcard matching
                       /\.\*\.\*\\\// => "(.*\\/)?"   # replace **/ with an optional wildcard mapping for folders (.*\/)?
    /#{re_str}/                       
  end
  
end

class Regexp
  
  def to_watcher_guard
    self
  end
end

module FsWatcher
  
  module WatcherSyntax
  
    attr_accessor :path, :filters, :subdirs, :handlers
  
    def path(val = nil)
      @path = val if val
      @path
    end

    def filter(*val)
      @filters = register_filters @filters, *val
    end

    def top_level_only
      @subdirs = false
    end

    def recurse
      @subdirs = true
    end
    alias_method :include_subdirs, :recurse

    def on(action, *filters, &handler)
      @handlers ||= {}
      hand = @handlers[action.to_sym]      
      @handlers[action.to_sym] = register_handlers(hand, *filters, &handler)
    end
  
    private 
    def register_filters(coll, *val)
      val.inject(coll||[]) { |memo, filt| memo << filt unless memo.include?(filt); memo  }
    end
  
  def register_handlers(registration, *filters, &handler)
    hand = { :handlers => [], :filters => [] }.merge(registration||{})
    hand[:handlers] << handler
    hand[:filters] = register_filters hand[:filters], *filters
    hand
  end
  end

  class WatcherBucket
    
    attr_reader :items
    
    include Enumerable
    
    def initialize
      @items = []
    end

    def <<(watcher)
      @items << watcher
    end

    def start_watching
      @items.each { |w| w.start } 
    end

    def stop_watching
      @items.each { |w| w.stop }
    end
    
    def each(&b)
      @items.each &b
    end
    
    def collect(&b)
      @items.inject(WatcherBucket.new) { |memo, watch| memo << b.call(watch)   }
    end
    alias_method :map, :collect
  end
  
  class WatcherBuilder
    
    include WatcherSyntax
    
    def initialize(path, *filters, &configure)
      @path = path
      @filters = register_filters [], *filters  
      @subdirs = false
      @handlers = {}    
      instance_eval &configure if configure
    end
    
    def build
      watcher = Watcher.new @path, @filters, @subdirs, @handlers
    end

    def method_missing(name, *args, &b)
      if name.to_s =~ /^on_(.*)/
        self.on $1, *args, &b
      else
        super
      end 
    end
    
    def self.watch(path, *filters, &b)
      @watchers << WatcherBuilder.new(path, *filters, &b).build
    end
    
    def self.build(&b)
      @watchers = WatcherBucket.new
      instance_eval(&b)
      @watchers.start_watching
      @watchers
    end
    
  end
  
  class Watcher

    include System::IO
    include WatcherSyntax

    ACTIONS = %w(changed created deleted renamed error)
    
    def handle(action, args)
      hand = @handlers[action.to_sym] 
      (hand[:handlers] || []).each { |handler| 
        handler.call args if hand.filters.all? { |filt| passes }
      }
      nil
    end

    def trigger(action, args)
      return nil unless guards_pass_for action, args
      handle action, args
    end
    
    def guards_pass_for(action, args)
      return true if filters.empty? and handlers[action.to_sym][:filters].empty?
      filters.all? { |g| passes_guard(g, (action == :rename ? args.old_path : args.path)) }
    end
    
    def passes_guard(guard, path)
      guard.to_watcher_guard.matches(path.gsub(/\\/, "/"))
    end

    def initialize(path, filters={}, include_subdirs=true, handlers={})
      @path, @filters, @subdirs, @handlers = path, filters, include_subdirs, handlers
    end

    def start
      @watcher ||= init_watcher  # postpone building the actual watcher until the last moment
      @watcher.enable_raising_events = true unless @watcher.enable_raising_events
    end

    def stop
      @watcher.enable_raising_events = false if @watcher and @watcher.enable_raising_events
    end

    def dispose
      self.stop
      @watcher.dispose if @watcher
      @watcher = nil
    end

    def init_watcher
      watcher = FileSystemWatcher.new @path, @filter
      watcher.include_subdirectories = @subdirs
      watcher.notify_filter = NotifyFilters.last_write | NotifyFilters.file_name | NotifyFilters.directory_name
      setup_internal_handlers watcher
      @watcher = watcher
    end
    
    def method_missing(name, *args, &b)
      if name =~ /^(on|handle|trigger)_(.*)/
        self.send $1, $2, *args, &b
      else
        super
      end 
    end
    
    private 
    def setup_internal_handlers(watcher)
      ACTIONS.each do |action|
        watcher.send("#{action}") { |_, args| trigger action, args } unless @handlers[action.to_sym].empty?
      end
      
    end

  end
  
  def self.configure(&b)
    FsWatcher::WatcherBuilder.build(&b)
  end

end

def filesystem(&b)
  FsWatcher.configure(&b)
end



