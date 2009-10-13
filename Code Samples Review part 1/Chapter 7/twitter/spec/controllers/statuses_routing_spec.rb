require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StatusesController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "statuses", :action => "index").should == "/statuses"
    end
  
    it "should map #new" do
      route_for(:controller => "statuses", :action => "new").should == "/statuses/new"
    end
  
    it "should map #show" do
      route_for(:controller => "statuses", :action => "show", :id => 1).should == "/statuses/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "statuses", :action => "edit", :id => 1).should == "/statuses/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "statuses", :action => "update", :id => 1).should == "/statuses/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "statuses", :action => "destroy", :id => 1).should == "/statuses/1"
    end

    it "should map #user_timeline" do
      route_for(:controller => "statuses", :action => "user_timeline").should == "/statuses/user_timeline"
    end

    it "should map #friends_timeline" do
      route_for(:controller => "statuses", :action => "friends_timeline").should == "/statuses/friends_timeline"
    end

    it "should map #public_timeline" do
      route_for(:controller => "statuses", :action => "public_timeline").should == "/statuses/public_timeline"
    end

    it "should map #replies" do
      route_for(:controller => "statuses", :action => "replies").should == "/statuses/replies"
    end

    it "should map #friends" do
      route_for(:controller => "statuses", :action => "friends").should == "/statuses/friends"
    end

    it "should map #followers" do
      route_for(:controller => "statuses", :action => "followers").should == "/statuses/followers"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/statuses").should == {:controller => "statuses", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/statuses/new").should == {:controller => "statuses", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/statuses").should == {:controller => "statuses", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/statuses/1").should == {:controller => "statuses", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/statuses/1/edit").should == {:controller => "statuses", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/statuses/1").should == {:controller => "statuses", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/statuses/1").should == {:controller => "statuses", :action => "destroy", :id => "1"}
    end

    it "should generate params for #user_timeline" do
      params_from(:replies, "/statuses/user_timeline").should == {:controller => "statuses", :action => "user_timeline"}
    end

    it "should generate params for #friends_timeline" do
      params_from(:replies, "/statuses/friends_timeline").should == {:controller => "statuses", :action => "friends_timeline"}
    end

    it "should generate params for #public_timeline" do
      params_from(:replies, "/statuses/public_timeline").should == {:controller => "statuses", :action => "public_timeline"}
    end

    it "should generate params for #replies" do
      params_from(:replies, "/statuses/replies").should == {:controller => "statuses", :action => "replies"}
    end

    it "should generate params for #friends" do
      params_from(:replies, "/statuses/friends").should == {:controller => "statuses", :action => "friends"}
    end

    it "should generate params for #followers" do
      params_from(:replies, "/statuses/followers").should == {:controller => "statuses", :action => "followers"}
    end

  end
end
