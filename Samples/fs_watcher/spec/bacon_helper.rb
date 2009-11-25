require 'bacon'
require 'caricature'

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'fs_watcher'

shared "a class with WatcherSyntax" do
  
  describe "initializing" do 
    
    it "should raise an error when no path is given" do
      lambda { FsWatcher::WatcherBuilder.new  }.should.raise(ArgumentError)
    end
    
    it "should have a path" do
      builder = FsWatcher::WatcherBuilder.new "/path/to/file"
      builder.path.should == "/path/to/file"
    end
    
    it "should have an empty filters collection when no filter is provided" do
      builder = FsWatcher::WatcherBuilder.new "/path/to/file"
      builder.filters.should.be.empty
    end
    
    it "should register the filters" do
      builder = FsWatcher::WatcherBuilder.new "/path/to/file", "*.rb"
      builder.filters.should == ["*.rb"]
    end
    
    it "should by default not recurse in subdirs" do
      builder = FsWatcher::WatcherBuilder.new "/path/to/file", "*.rb"
      builder.subdirs.should.be.false
    end
    
    it "should register and execute the block" do
      $path = ""
      FsWatcher::WatcherBuilder.new("/path/to/file") { $path = self.path }
      $path.should == "/path/to/file"
    end
    
  end
  
  describe "when initialized" do
    
    before do
      @builder = FsWatcher::WatcherBuilder.new "/path/to/file" , "*.rb"
    end
    
    it "should allow setting the path" do
      @builder.path "/path/to/another/file"
      @builder.path.should == "/path/to/another/file"
    end
    
    it "should allow setting extra filters" do
      @builder.filter "*.txt", "*.py"
      @builder.filters.should == ["*.rb", "*.txt", "*.py"]
    end
    
    it "should disable recursing into subdirs" do
      @builder.recurse
      @builder.top_level_only
      @builder.subdirs.should.be.false      
    end
    
    it "should enable recursing into subdirs" do
      @builder.recurse
      @builder.subdirs.should.be.true
    end
    
    describe "registering handlers" do
      
      it "should register a handler without a filter" do
        hand = lambda { |args| }
        @builder.on :change, &hand
        @builder.handlers[:change][:default].should == [hand]
      end
      
      it "should register a handler with a filter" do
        hand = lambda { |args| }
        @builder.on :change, "*.rb", &hand
        @builder.handlers[:change]["*.rb"].should == [hand]
      end
      
      it "should register a handler by method name" do
        hand = lambda { |args| }
        @builder.on_change "*.rb", &hand
        @builder.handlers[:change]["*.rb"].should == [hand]
      end
      
    end
    
  end
  
end