raise "This library requires the .NET framework so you need IronRuby" unless defined? IRONRUBY_VERSION

require 'System'

# A small quick and dirty dsl for defining file system watches
module FsWatcher

  
  class Watcher

    include System::IO

    ACTIONS = %w(change create delete rename error)

    attr_accessor :path, :filter, :sudirs

    include WatcherOps

    ACTIONS.each do |act|
      class_eval <<-DEF
def on_#{act}(&handler)
  @#{act}_actions ||= []
  @watcher.on_#{act}#{"d" unless act == 'error'} { |_, args| trigger :#{act}, args } unless @#{act}_attached;
  @#{act}_attached = true
  @#{act}_actions << handler
end

def handle_#{act}(args)
  (@#{act}_actions || []).each { |handler| handler.call args }
  nil
end
      DEF
    end

    def trigger(action, args)
      send "handle_#{action}", args
    end

    def initialize
      @path, @filter, @subdirs = path, filter, include_subdirs
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
      @watcher.dispose
      @watcher = nil
    end

    def init_watcher
      watcher = FileSystemWatcher.new @path, @filter
      watcher.include_subdirectories = @include_subdirs
      watcher.notify_filter = NotifyFilters.last_write | NotifyFilters.file_name | NotifyFilters.directory_name
      watcher.changed { |_, args| trigger :change, args }
      watcher.renamed { |_, args| trigger :rename, args }
      @watcher = watcher
    end

    def filter=(val)
      @filter = val if @filter != val
    end

    def subdirs(val)
      @subdir = val if @subdirs != val
    end

  end

  module WatcherOps

    def watch(path, filter="*.rb", include_subdirs=true)
      self.path path
      self.filter filter
      include_subdirs ? self.recurse : self.top_level_only
    end

    def path(val)
      @path = val
    end

    def filter(val)
      @filter = val unless @filter and @filter == val
    end

    def top_level_only
      @subdirs = false
    end

    def recurse
      @subdirs = true
    end

    def on(action, &handler)
      self.send "on_#{action}", &handler
    end

    Watcher::ACTIONS.each do |act|
      attr_accessor "#{act}_actions".to_sym
      class_eval <<-DEF
def on_#{act}(&handler)
  @#{act}_actions ||= []
  @#{act}_actions << handler
end
      DEF
    end

  end

end

def filesystem(&b)
end