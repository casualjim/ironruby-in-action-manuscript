# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/light_speed_repository'


describe LightSpeedRepository do
  before(:each) do
    @light_speed_entity_generator = LightSpeedRepository.new
  end

  it "should have meta data" do
    
    %w(tables primary_keys foreign_keys column_info).each do |md|
      @light_speed_entity_generator.should respond_to(md)
      @light_speed_entity_generator.send(md.to_sym).should_not be_nil
    end
    
  end
  
  it "should generate a collection of tables as classes" do
    @light_speed_entity_generator.stubs(:tables).returns(["Customers", "Sheep", "letters"])
    
    result = @light_speed_entity_generator.generate_classes
    result[0].should eql("Customer")
    result[1].should eql("Sheep")
    result[2].should eql("Letter")
  end
  
  it "should need conventionalising for a table with 1 PK that isn't called Id" do
    tables = @light_speed_entity_generator.stubs(:tables).returns([{:name => "Customers"}])
    @light_speed_entity_generator.stubs(:primary_keys_for).returns([{:column_name => "CustomerID"}])
    
    result = @light_speed_entity_generator.needs_conventionalising?
    result.should eql(true )
  end
end

