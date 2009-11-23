require File.join(File.dirname(__FILE__), "bacon_helper")


describe "WatcherBucket" do
  
  before do
    @buck = FsWatcher::WatcherBucket.new
  end
  
  it "should allow adding of items" do
    @buck << { :the_item => "an item" }
    @buck.items.should == [{ :the_item => "an item" }]
  end
  
  it "should allow starting the items" do
    item = Caricature::Isolation::for(FsWatcher::Watcher)
    @buck << item
    @buck.start_watching
    item.did_receive?(:start).should.be.successful
  end
  it "should stop the items" do
    item = Caricature::Isolation::for(FsWatcher::Watcher)
    @buck << item
    @buck.stop_watching
    item.did_receive?(:stop).should.be.successful
  end
  
  it "should collect the items into a new WatcherBucket" do
    item = { :an_item => "the item" }
    @buck << { :the_item => "an item" }
    exp = FsWatcher::WatcherBucket.new
    exp << item
    @buck.collect { |w| item }.should == exp
  end
  
  
end