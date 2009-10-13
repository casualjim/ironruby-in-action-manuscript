require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/statuses/new.html.erb" do
  include StatusesHelper
  
  before(:each) do
    assigns[:status] = stub_model(Status,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/statuses/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", statuses_path) do
    end
  end
end


