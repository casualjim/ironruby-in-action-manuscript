require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Status do
  before(:each) do
    @valid_attributes = {
      :favourited => false,
      :in_reply_to_status_id => "1",
      :in_reply_to_user_id => "1",
      :source => "value for source",
      :source_url => "value for source_url",
      :text => "value for text",
      :truncated => false
    }
  end

  it "should create a new instance given valid attributes" do
    Status.create!(@valid_attributes)
  end
end
