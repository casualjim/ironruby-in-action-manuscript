# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/light_speed_repository'


describe LightSpeedRepository do
  
  before(:each) do
    @light_speed_entity_generator = LightSpeedRepository.new
  end
  
  describe DB::MetaData do
    
    it "should have meta data" do

      %w(tables primary_keys foreign_keys column_info).each do |md|
        @light_speed_entity_generator.should respond_to(md)
        @light_speed_entity_generator.send(md.to_sym).should_not be_nil
      end

    end
    
    it "should return the through associations" do
      fks = expected_foreign_keys
      fks << { :table_name => "test_table", :child_id => "test_foreign_key", :parent_table => "other_test_parent_table", :parent_id => "test_id" }
      fks << { :table_name => "test_table", :child_id => "test_foreign_key", :parent_table => "another_test_parent_table", :parent_id => "test_id" }
      fks << { :table_name => "other_test_table", :child_id => "test_foreign_key", :parent_table => "other_test_parent_table", :parent_id => "test_id" }
      
      @light_speed_entity_generator.stubs(:foreign_keys).returns(fks)
      
      @light_speed_entity_generator.collect_through_associations("test_parent_table").should == ["other_test_parent_table", "another_test_parent_table"]
    end
    
    it "should return the end point tables for a given through association" do
      fks = expected_foreign_keys
      fks << { :table_name => "test_table", :child_id => "test_foreign_key", :parent_table => "other_test_parent_table", :parent_id => "test_id" }
      fks << { :table_name => "test_table", :child_id => "test_foreign_key", :parent_table => "another_test_parent_table", :parent_id => "test_id" }
      
      @light_speed_entity_generator.stubs(:foreign_keys).returns(fks)
      
      @light_speed_entity_generator.get_endpoint_tables("test_parent_table", "test_table").should == ["other_test_parent_table", "another_test_parent_table"]
    end
    
    it "should return the has many relations given a table" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.collect_has_many_relations("test_parent_table").should == [{:table_name => "test_table"}, {:table_name => "other_test_table"}]
    end
    
    it "should return an empty array of has many relations when there are none" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.collect_has_many_relations("test_parent_table2").should be_empty
    end
    
    it "should identify a table as a join table under the correct conditions" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.should be_join_table(expected_foreign_keys[0][:table_name])
    end
    
    it "should not identify a table as a join table under the correct conditions" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns([{ :table_name => "test_table", :child_id => "test_foreign_key" }])

      @light_speed_entity_generator.should_not be_join_table(expected_foreign_keys[0][:table_name])
    end
    
    it "should identify a given column as being a primary key" do
      @light_speed_entity_generator.stubs(:primary_keys).returns([{ :table_name => "test_table", :column_name => "id" }])
      
      @light_speed_entity_generator.should be_primary_key({:table_name => "test_table", :name => "id" })
    end
    
    it "should not identify a given column as being a primary key" do
      @light_speed_entity_generator.stubs(:primary_keys).returns([{ :table_name => "test_table", :column_name => "id" }])
      
      @light_speed_entity_generator.should_not be_primary_key({:table_name => "test_table", :name => "my_id" })
    end
    
    it "should identify a foreign key given a valid column info" do
       @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.should be_foreign_key(:table_name => expected_foreign_keys[0][:table_name], :name => expected_foreign_keys[0][:child_id])
    end

    it "should identify a given column as not being a foreign key" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.should_not be_foreign_key(:table_name => "other_table", :name => expected_foreign_keys[0][:child_id])
    end

    it "should resolve the table name from a hash" do
      table_name = "my table"
      @light_speed_entity_generator.table_name({:name => table_name}).should == table_name
    end

    it "should resolve the table name from a string" do
      table_name = "my table"
      @light_speed_entity_generator.table_name(table_name).should == table_name
    end
    
  end
  
  describe "Conversion" do
    
    it "should convert a given table to light speed metadata" do 
      table = {:name => "test_table"}
      @light_speed_entity_generator.stubs(:tables).returns([table])
      @light_speed_entity_generator.stubs(:column_info_for).returns(column_infos)
      @light_speed_entity_generator.stubs(:primary_key?).returns(false)

      result = @light_speed_entity_generator.to_light_speed_meta_data

      result.should_not be_empty
      result[0][:table_name].should eql(table[:name])
      result[0][:class_name].should eql("TestTable")
      result[0][:fields].size.should eql(2)
      result[0][:fields].each_index do |i|
        result[0][:fields][i][:name].should == column_infos[i][:name]
        result[0][:fields][i][:sql_type].should == column_infos[i][:sql_type]
        result[0][:fields][i][:max_length].should == column_infos[i][:max_length]
        result[0][:fields][i][:nullable].should == column_infos[i][:is_nullable]
        result[0][:fields][i][:precision].should == column_infos[i][:precision]
        result[0][:fields][i][:foreign_key].should be_false
        result[0][:fields][i][:primary_key].should be_false
        result[0][:fields][i][:unique].should be_false
      end

    end
    
  end
  
  describe "Conventionalising" do
  
    it "should say it doesn't follow conventions for a table with 1 PK that isn't called Id" do
      tables = @light_speed_entity_generator.stubs(:tables).returns([{:name => "Customers"}])
      @light_speed_entity_generator.stubs(:primary_keys_for).returns([{:column_name => "CustomerID"}])
    
      result = @light_speed_entity_generator.should_not be_conventionalized
    end
  
    it "should say it does follow conventions for a table with 1 PK that is called Id" do
      tables = @light_speed_entity_generator.stubs(:tables).returns([{:name => "Customers"}])
      @light_speed_entity_generator.stubs(:primary_keys_for).returns([{:column_name => "Id"}])
    
      @light_speed_entity_generator.should be_conventionalized
    end
  
    it "should say it doesn't follow conventions for a table without a PK" do
      tables = @light_speed_entity_generator.stubs(:tables).returns([{:name => "Customers"}])
      @light_speed_entity_generator.stubs(:primary_keys_for).returns([])
    
      @light_speed_entity_generator.should_not be_conventionalized
    end
  
    it "should say it doesn't follow conventions for a table with 2 PK's" do
      tables = @light_speed_entity_generator.stubs(:tables).returns([{:name => "Customers"}])
      @light_speed_entity_generator.stubs(:primary_keys_for).returns([{:column_name => "CustomerId"}, {:column_name => "CustomerTypeId"}])
    
      @light_speed_entity_generator.should_not be_conventionalized
    end
    
  end
  
  private 
    def expected_foreign_keys
      [ 
        { :table_name => "test_table", :child_id => "test_foreign_key", :parent_table => "test_parent_table", :parent_id => "test_id" },
        { :table_name => "test_table", :child_id => "test_foreign_key_2" },
        { :table_name => "other_test_table", :child_id => "test_foreign_key", :parent_table => "test_parent_table", :parent_id => "test_id" }
      ]
    end
    
    def column_infos
      [
        {:name => "test_id", :sql_type => 'int', :max_length => 4, :is_nullable => false, :precision => nil, :table_name => "test_parent_table", :is_unique => false},
        {:name => "test_name", :sql_type => 'string', :max_length => 255, :is_nullable => true, :precision => nil, :table_name => "test_parent_table", :is_unique => false}
      ]
    end
    
end

