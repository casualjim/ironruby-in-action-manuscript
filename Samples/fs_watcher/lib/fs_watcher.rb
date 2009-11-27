#### End goal

# filesystem do
#   watch("/path/to/watch", /_spec.rb$/ui) do
#     on_change { |args| # do stuff here with args.full_path or args.name }
#     on_change /integration\/.*_spec.rb/ { |args| # do stuff here with args.full_path or args.name } 
#     on_rename { |args| # do stuff here with args.full_path, args.name, args.old_path or args.old_name }
#     on_rename "*.rb" { |args| # do stuff here with args.path, args.name, args.old_path or args.old_name } 
#     on_delete { |args| # do stuff here with args.full_path or args.name } 
#     on_create { |args| # do stuff here with args.full_path or args.name } 
#     on_error  { |args| # do stuff here with args.full_path or args.name } 
#   end
#   watch("/another/path/to/watch", /app\/.*\.rb$/ui) do
#     on_change { |args| # do stuff here with args.full_path or args.name } 
#     on_rename { |args| # do stuff here with args.full_path, args.name, args.old_full_path or args.old_name } 
#     on_delete { |args| # do stuff here with args.full_path or args.name } 
#     on_create { |args| # do stuff here with args.full_path or args.name } 
#     on_error  { |args| # do stuff here with args.full_path or args.name } 
#   end
# end

raise "This library requires the .NET framework so you need IronRuby" unless defined? IRONRUBY_VERSION

require 'System'

class String
  
  alias :old_gsub :gsub
  def gsub(pattern, replacement=nil, &b)
    if pattern.is_a? Hash
      pattern.inject(self.dup) { |memo, k| memo.old_gsub(k.first, k.last) }
    else
      self.old_gsub(pattern, replacement, &b)
    end
  end
  
  def to_watcher_guard
    re_str = self.gsub /(\/)/ => '\/',                # normalize \\ on windows to /
                       /\./ => '\.',                  # replace . with an escaped \.
                       /\?/ => '.?',                  # replace ? with an optional caracter .?
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
      @handlers[action.to_sym] ||= {}   
      hand = @handlers[action.to_sym] 
      filters = [:default] if filters.empty?
      filters.each do |filt|
        filt = :default if filt.to_s.empty?
        hand[filt] ||= []
        hand[filt] << handler
      end
    end
  
    private 
    def register_filters(coll, *val)
      val.inject(coll||[]) { |memo, filt| memo << filt unless memo.include?(filt); memo  }
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
    
    def dispose
      @items.each { |w| w.dispose }
      @items=nil
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
      Watcher.new @path, @filters, @handlers, @subdirs
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

    ACTION_MAP = { :changed => :change, :created => :create, :deleted => :delete, :renamed => :rename, :error => :error }
    
    def handle(action, args)
      @handled ||= {}
      path = args_path(action, args)
      hand = @handlers[action.to_sym] 
      hand.each_pair do |filter, handlers|
        handlers.each do |h| 
          if not handled?(h, path) 
            h.call(args) 
            @handled[path] ||= []
            @handled[path] << h
          end
        end if passes_guard?(filter, path)
      end
      nil
    end

    def trigger(action, args)
      @handled = {}
      return nil unless guards_pass_for action, args
      handle action, args
    end

    def initialize(path, filters={}, handlers={}, include_subdirs=true)
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
    
    def method_missing(name, *args, &b)
      if name =~ /^(on|handle|trigger)_(.*)/
        self.send $1, $2, *args, &b
      else
        super
      end 
    end
    
    def self.watcher_class
      @@watcher_class ||= FileSystemWatcher
    end
    
    def self.watcher_class=(value)
      @@watcher_class = value
    end
    
    private 
    def guards_pass_for(action, args)
      return true if filters.empty? 
      filters.all? { |g| passes_guard?(g, args_path(action, args)) }
    end
    
    def passes_guard?(guard, path)
      return true if guard == :default
      guard.to_watcher_guard.match(path.gsub(/\\/, "/"))
    end
    
    def handled?(handler, path)
      (@handled[path]||[]).include?(handler)
    end
    
    def args_path(action, args)
      (action == :rename ? args.old_full_path : args.full_path)
    end
    
    def init_watcher
      watcher = self.class.watcher_class.new @path
      watcher.include_subdirectories = @subdirs
      setup_internal_handlers watcher
      @watcher = watcher
    end
    
    def setup_internal_handlers(watcher)
      ACTION_MAP.each_pair do |event, action|
        nothing_registered = (@handlers[action]||{}).empty?
        watcher.send("#{event}") { |_, args| trigger action, args } unless nothing_registered
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



