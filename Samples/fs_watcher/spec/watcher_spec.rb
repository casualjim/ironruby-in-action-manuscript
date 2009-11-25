require File.join(File.dirname(__FILE__), "bacon_helper")

class Args
  
  def initialize(value="/path/to/file")
    @pth = value
  end
  
  def path
    @pth
  end
end

describe "Watcher" do
  
  behaves_like "a class with WatcherSyntax"
  
  it "should handle events without guards" do
    counter = 0
    handler = lambda { |args| counter += 1  }
    h = { :change => { :default => [handler] } }
    w = FsWatcher::Watcher.new "/path/to/file", [], h
    w.handle :change, Args.new
    counter.should == 1
  end
  
  it "should handle events with passing guards" do
    counter = 0
    handler = lambda { |args| counter += 1  }
    h = { :change => { /\/file/ => [handler] } }
    w = FsWatcher::Watcher.new "/path/to/file", [], h
    w.handle :change, Args.new
    counter.should == 1
  end
  
  it "should not raise events with failing guards" do
    counter = 0
    handler = lambda { |args| counter += 1  }
    h = { :change => { /\/file2/ => [handler] } }
    w = FsWatcher::Watcher.new "/path/to/file", [], h
    w.handle :change, Args.new
    counter.should == 0
  end
  
  it "should trigger events with passing guards" do
    counter = 0
    handler = lambda { |args| counter += 1  }
    w = FsWatcher::Watcher.new "/path/to/file", [/file/], {:change => {:default => [handler]}}
    w.trigger :change, Args.new
    counter.should == 1
  end
  
  it "should not trigger events with failing guards" do
    counter = 0
    handler = lambda { |args| counter += 1  }
    w = FsWatcher::Watcher.new "/path/to/file", [/file2/], {:change => {:default => [handler]}}
    w.trigger :change, Args.new
    counter.should == 0
  end
  
  it "should start the watcher" do
    iso = Caricature::Isolation.for(System::IO::FileSystemWatcher)
    FsWatcher::Watcher.watcher_class = iso.class
    counter = 0
    handler = lambda { |args| counter += 1  }
    h = { :change => { /\/file2/ => [handler] } }
    w = FsWatcher::Watcher.new "/path/to/file", [], h
    w.instance_variable_set "@watcher", iso
    w.start
    iso.did_receive?(:enable_raising_events=).with(true).should.be.successful
  end
  
  it "should stop the watcher" do
    iso = Caricature::Isolation.for(System::IO::FileSystemWatcher)
    FsWatcher::Watcher.watcher_class = iso.class
    counter = 0
    handler = lambda { |args| counter += 1  }
    h = { :change => { /\/file2/ => [handler] } }
    w = FsWatcher::Watcher.new "/path/to/file", [], h
    iso.when_receiving(:enable_raising_events).return(true)
    w.instance_variable_set "@watcher", iso
    w.stop
    iso.did_receive?(:enable_raising_events=).with(false).should.be.successful
  end
  
  it "should dispose the watcher" do
    iso = Caricature::Isolation.for(System::IO::FileSystemWatcher)
    FsWatcher::Watcher.watcher_class = iso.class
    counter = 0
    handler = lambda { |args| counter += 1  }
    h = { :change => { /\/file2/ => [handler] } }
    w = FsWatcher::Watcher.new "/path/to/file", [], h
    iso.when_receiving(:enable_raising_events).return(true)
    w.instance_variable_set "@watcher", iso
    w.dispose
    iso.did_receive?(:enable_raising_events=).with(false).should.be.successful
    iso.did_receive?(:dispose).should.be.successful
    w.instance_variable_get("@watcher").should.be.nil
  end
  
end