require 'bacon'

describe "loading the library" do
  
  it "should raise an exception when IRONRUBY_VERSION is undefined" do
    old_ver = IRONRUBY_VERSION
    Object.send :remove_const, :IRONRUBY_VERSION
    lambda { load File.dirname(__FILE__) + "/../lib/fs_watcher.rb" }.should.raise(/IronRuby/)
    IRONRUBY_VERSION = old_ver
  end
end