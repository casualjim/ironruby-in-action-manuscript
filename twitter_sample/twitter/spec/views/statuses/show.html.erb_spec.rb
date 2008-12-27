require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/statuses/show.html.erb" do
  include StatusesHelper
  
  before(:each) do
    assigns[:status] = @status = stub_model(Status)
  end

  it "should render attributes in <p>" do
    render "/statuses/show.html.erb"
  end
end

