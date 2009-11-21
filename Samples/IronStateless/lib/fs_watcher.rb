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
  
  alias :old_gsub, :gsub
  def gsub(pattern, replacement=nil, &b)
    if pattern.is_a? Hash
      pattern.inject(self.dup) { |memo, k, v| memo.old_gsub k, v }
    else
      old_gsub(pattern, replacement, &b)
    end
  end
  
end

# A small quick and dirty dsl for defining file system watches
module FsWatcher

  
  class Watcher

    include System::IO

    ACTIONS = %w(changed created deleted renamed error)

    attr_accessor :path, :filters, :sudirs, :handlers

    include WatcherOps
    
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
      filters.all? { |g| passes_guard g, action == :rename ? args.old_path : args.path }
    end
    
    def passes_guard(guard, path)
      guard = guard.class.respond_to? :last_match ? guard : regexify(guard)
      guard.matches(path.gsub(/\\/, "/"))
    end
    
    def regexify(glob_pattern)
      
      re = glob_pattern.gsub /(\/)/ => '\/',                # normalize \\ on windows to /
                             /\./ => '\.',                  # replace . with an escaped \.
                             /\?/ => '.?',                  # replace ? with an optional charachter .?
                             /\*/ => ".*",                  # replace * with .* for wildcard matching
                             /\.\*\.\*\\\// => "(.*\\/)?"   # replace **/ with an optional wildcard mapping for folders (.*\/)?
       #.gsub(/(\/)/, '\/').gsub(/\./, "\\.").gsub(/\?/, ".?").gsub(/\*\.?/, ".*").gsub(/\.\*\.\*\\\//, "(.*\\/)?")
      /#{re}/
    end

    def initialize(path, filters={}, include_subdirs=true, handlers={})
      @path, @filters, @subdirs, @handlers = path, filters, include_subdirs, handlers
    end

    def start
      @watcher ||= init_watcher
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
      if name =~ /^(on|handle)_(.*)/
        self.send $1, $2, *args, &b
      else
        super
      end 
    end
    
    private 
    def setup_internal_handlers(watcher)
      ACTIONS.each do |action|
        watcher.send "#{action}" { |_, args| trigger action, args } unless @handlers[action.to_sym].empty?
      end
      
    end

  end

  module WatcherOps

    def path(val)
      @path = val
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

    def on(action, *filters, &handler)
      @handlers ||= {}
      hand = @handlers[action.to_sym]
      hand[:handlers] ||= []
      hand[:handlers] << handler
      hand[:filters] = register_filters hand[:filters], *filters
    end
    
    private
    def register_filters(coll, *val)
      val.inject(coll||[]) { |memo, filt| memo << filt unless memo.include?(filt); memo  }
    end

  end
  
  class WatcherBuilder
    
    include WatcherOps
    
    def initialize(path, *filters, &b)
      self.path path
      register_filters *filters
      intance_eval(&b)
    end
    
    def build
      watcher = Watcher.new @path, @filters, @subdirs, @handlers
    end
    
    def method_missing(name, *args, &b)
      if name =~ /^on_(.*)/
        self.on $1, &b
      else
        super
      end 
    end
    
    def self.watch(path, *filters, &b)
      WatcherBuilder.new(path, *filters, &b).build
    end
  end

end

def filesystem(&b)
  watchers ||= []
  watchers << WatcherBuilder.instance_eval(&b).build
  watchers.each { |w| w.start }
  watchers
end



