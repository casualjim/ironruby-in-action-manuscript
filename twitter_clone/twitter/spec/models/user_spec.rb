require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @valid_attributes = {
      :description => "value for description",
      :favourites_count => "1",
      :followers_count => "1",
      :following => false,
      :friends_count => "1",
      :location => "value for location",
      :name => "value for name",
      :profile_image_url => "value for profile_image_url",
      :protected => false,
      :statuses_count => "1",
      :screen_name => "value for screen_name",
      :time_zone => "value for time_zone",
      :url => "value for url",
      :utc_offset => "value for utc_offset"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end
end
