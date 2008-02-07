
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/light_speed_entity.rb'

describe LightSpeedEntity do
  before(:each) do
    @light_speed_entity = LightSpeedEntity.new
  end
  
  it "should create a valid property name if two already exist in the properties" do
    @light_speed_entity.stubs(:properties).returns([{ :name => "MyName" }, { :name => "MyName1" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName2"
  end
  
  it "should create a valid property name if two already exist in the belongs to properties" do
    @light_speed_entity.stubs(:belongs_to).returns([{ :name => "MyName" }, { :name => "MyName1" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName2"
  end
  
  it "should create a valid property name if two already exist in the has many properties" do
    @light_speed_entity.stubs(:has_many).returns([{ :name => "MyName" }, { :name => "MyName1" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName2"
  end
  
  it "should create a valid property name if two already exist in the through association properties" do
    @light_speed_entity.stubs(:through_associations).returns([{ :name => "MyName" }, { :name => "MyName1" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName2"
  end
  
  it "should create a valid property name if one already exists in the properties" do
    @light_speed_entity.stubs(:properties).returns([{ :name => "MyName" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName1"
  end
  
  it "should create a valid property name if one already exists in the belongs to properties" do
    @light_speed_entity.stubs(:belongs_to).returns([{ :name => "MyName" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName1"
  end
  
  it "should create a valid property name if one already exists in the has many properties" do
    @light_speed_entity.stubs(:has_many).returns([{ :name => "MyName" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName1"
  end
  
  it "should create a valid property name if one already exists in the through association properties" do
    @light_speed_entity.stubs(:through_associations).returns([{ :name => "MyName" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName1"
  end
  
  it "should create a valid property name if one doesn't exists already in the properties" do
    @light_speed_entity.stubs(:properties).returns([{ :name => "Name" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName"
  end
  
  it "should create a valid property name if one doesn't exists already in the belongs to properties" do
    @light_speed_entity.stubs(:belongs_to).returns([{ :name => "Name" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName"
  end
  
  it "should create a valid property name if one doesn't exists already in the has many properties" do
    @light_speed_entity.stubs(:has_many).returns([{ :name => "Name" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName"
  end
  
  it "should create a valid property name if one doesn't exists already in the through association properties" do
    @light_speed_entity.stubs(:through_associations).returns([{ :name => "Name" }])
    @light_speed_entity.create_property_name_from("MyName").should == "MyName"
  end

  it "should have properties, has many, belongs to and through associations" do
    @light_speed_entity.properties.should_not be_nil
    @light_speed_entity.belongs_to.should_not be_nil
    @light_speed_entity.has_many.should_not be_nil
    @light_speed_entity.through_associations.should_not be_nil
  end
  
end

