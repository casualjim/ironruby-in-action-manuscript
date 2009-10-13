require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/statuses/index.html.erb" do
  include StatusesHelper
  
  before(:each) do
    assigns[:statuses] = [
      stub_model(Status),
      stub_model(Status)
    ]
  end

  it "should render list of statuses" do
    render "/statuses/index.html.erb"
  end
end

