require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/statuses/edit.html.erb" do
  include StatusesHelper
  
  before(:each) do
    assigns[:status] = @status = stub_model(Status,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/statuses/edit.html.erb"
    
    response.should have_tag("form[action=#{status_path(@status)}][method=post]") do
    end
  end
end


