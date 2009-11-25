require File.dirname(__FILE__) + "/bacon_helper"

describe "String" do
  
  it "should gsub with a Hash as parameter" do
    ori = "hello world is the canonical example"
    ori.gsub({
      /hello world/ => "Hello World",
      /canonical/ => "default"
    }).should == "Hello World is the default example"
  end
  
  it "should convert a path" do
    filter = "/path/to?/**/*.rb"
    filter.to_watcher_guard.should == /\/path\/to.?\/(.*\/)?.*\.rb/
  end
  
end