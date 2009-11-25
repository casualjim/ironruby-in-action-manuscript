require File.join(File.dirname(__FILE__), "bacon_helper")



describe "WatcherBuilder" do
  
  behaves_like "a class with WatcherSyntax"
  
  
  
  describe "when building watches" do
    
    before do
      class ::FsWatcher::WatcherBucket 

        attr_accessor :started 

        alias_method :old_start, :start_watching
        def start_watching
          @started = true
        end

        def started?
          !!@started
        end

      end
    end

    after do
      class ::FsWatcher::WatcherBucket 
        undef :start_watching
        undef :started?
        undef :started
        undef :started=
        alias_method :start_watching, :old_start

      end
    end
    
    it "should create a watcher" do
      builder          = FsWatcher::WatcherBuilder.new "/path/to/file" , "*.rb"
      h                = { :a_handler => "some handler" }
      builder.handlers = h
      res              = builder.build
      exp              = FsWatcher::Watcher.new("/path/to/file", ["*.rb"], h, false)
      res.path.should == exp.path
      res.handlers.should == exp.handlers
      res.filters.should == exp.filters
      res.subdirs.should == exp.subdirs
    end
    
    it "should register a new watcher in the watcher bucket" do
      hand = lambda {}
      h                = { :change => { "*.py" => [hand] } }
      FsWatcher::WatcherBuilder.instance_variable_set "@watchers", FsWatcher::WatcherBucket.new
      res = FsWatcher::WatcherBuilder.watch("/path/to/file" , "*.rb") do
        top_level_only
        on_change "*.py", &hand
      end.first
      exp = FsWatcher::Watcher.new("/path/to/file", ["*.rb"], h, false)
      res.path.should == exp.path
      res.handlers.should == exp.handlers
      res.filters.should == exp.filters
      res.subdirs.should == exp.subdirs
    end
    
    it "should register a new watcher and start it" do
      hand = lambda {}
      h                = { :change => { "*.py" => [hand] } }
      res = FsWatcher::WatcherBuilder.build do
        watch("/path/to/file" , "*.rb") do
          top_level_only
          on_change "*.py", &hand
        end
      end
      res.should.be.started
    end

  end
  
end



