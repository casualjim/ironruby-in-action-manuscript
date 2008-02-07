require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/light_speed_property.rb'

describe LightSpeedProperty do
  
  it "should be a lightSpeed property" do
    ls = LightSpeedProperty.new
    ls.should be_instance_of(LightSpeedProperty)
  end
  
  it "should return a sql type" do
    ls = LightSpeedProperty.new :sql_type => 'int'
    
    ls.should respond_to(:sql_type)
    ls.sql_type.should == "int"
  end
  
  it "should return a predicate for booleans" do
    ls = LightSpeedProperty.new :primary_key => true
    
    ls.should respond_to(:primary_key?)
    ls.should be_primary_key
  end
  
  it "should return a predicate for booleans" do
    ls = LightSpeedProperty.new :primary_key => false
    
    ls.should respond_to(:primary_key?)
    ls.should_not be_primary_key
  end
  
  it "should allow for a property to be set" do
    ls = LightSpeedProperty.new :sql_type => 'int'
    
    ls.sql_type = 'string'
    ls.sql_type.should eql('string')
     
  end
end

