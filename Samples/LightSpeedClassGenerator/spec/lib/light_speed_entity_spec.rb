
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/light_speed_entity.rb'

describe LightSpeedEntity do
  before(:each) do
    @light_speed_entity = LightSpeedEntity.new
  end

  it "should have properties, has many, belongs to and through associations" do
    @light_speed_entity.properties.should_not be_nil
    @light_speed_entity.belongs_to.should_not be_nil
    @light_speed_entity.has_many.should_not be_nil
    @light_speed_entity.through_associations.should_not be_nil
  end
end

