# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../lib/light_speed_repository'


describe LightSpeedRepository do
  before(:each) do
    db = mock("db::dbi_sql_server")
    DB::DbiSqlServer.stubs(:new).returns(db)
    db.stubs(:fetch_all).returns(nil)
    
    @light_speed_entity_generator = LightSpeedRepository.new
  end
  
  
  describe DB::MetaData do
    
    
    it "should return the through associations" do
      fks = expected_foreign_keys
      
      
      @light_speed_entity_generator.stubs(:foreign_keys).returns(fks)
      
      @light_speed_entity_generator.collect_through_associations("test_parent_tables").should == [
        {:through_table=>"test_tables", :end_tables=>["other_test_parent_tables", "another_test_parent_tables"]}, 
        {:through_table=>"other_test_tables", :end_tables=>["other_test_parent_tables"]}
      ]
    end
    
    it "should return the end point tables for a given through association" do
      fks = expected_foreign_keys
      
      @light_speed_entity_generator.stubs(:foreign_keys).returns(fks)
      
      @light_speed_entity_generator.get_endpoint_tables("test_parent_tables", "test_tables").should == ["other_test_parent_tables", "another_test_parent_tables"]
    end
    
    it "should return the has many relations given a table" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.collect_has_many_relations("test_parent_tables").should == [{:table_name => "test_tables", :class_name => "TestTable" }, { :table_name => "other_test_tables", :class_name => "OtherTestTable" }]
    end
    
    it "should return an empty array of has many relations when there are none" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.collect_has_many_relations("test_parent_tables2").should be_empty
    end
    
    it "should identify a table as a join table under the correct conditions" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.should be_join_table(expected_foreign_keys[0][:table_name])
    end
    
    it "should not identify a table as a join table under the correct conditions" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns([{ :table_name => "test_tables", :child_id => "test_foreign_key" }])

      @light_speed_entity_generator.should_not be_join_table(expected_foreign_keys[0][:table_name])
    end
    
    it "should identify a given column as being a primary key" do
      @light_speed_entity_generator.stubs(:primary_keys).returns([{ :table_name => "test_tables", :column_name => "id" }])
      
      @light_speed_entity_generator.should be_primary_key({:table_name => "test_tables", :name => "id" })
    end
    
    it "should not identify a given column as being a primary key" do
      @light_speed_entity_generator.stubs(:primary_keys).returns([{ :table_name => "test_tables", :column_name => "id" }])
      
      @light_speed_entity_generator.should_not be_primary_key({:table_name => "test_tables", :name => "my_id" })
    end
    
    it "should identify a foreign key given a valid column info" do
       @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.should be_foreign_key(:table_name => expected_foreign_keys[0][:table_name], :name => expected_foreign_keys[0][:child_id])
    end

    it "should identify a given column as not being a foreign key" do
      @light_speed_entity_generator.stubs(:foreign_keys).returns(expected_foreign_keys)

      @light_speed_entity_generator.should_not be_foreign_key(:table_name => "other_tables", :name => expected_foreign_keys[0][:child_id])
    end

    it "should resolve the table name from a hash" do
      table_name = "my table"
      @light_speed_entity_generator.table_name({:name => table_name}).should == table_name
    end

    it "should resolve the table name from a string" do
      table_name = "my table"
      @light_speed_entity_generator.table_name(table_name).should == table_name
    end
    
    it "should have meta data" do
      db = mock("db::dbi_sql_server")
      DB::DbiSqlServer.stubs(:new).returns(db)
      db.stubs(:fetch_all).returns({:tables => [], :primary_keys => [], :foreign_keys => [], :column_info => []})

      @light_speed_entity_generator = LightSpeedRepository.new
      %w(tables primary_keys foreign_keys column_info).each do |md|
        @light_speed_entity_generator.should respond_to(md)
        @light_speed_entity_generator.send(md.to_sym).should_not be_nil
      end

    end
    
    
  end
  
  describe "Conversion" do
    
    it "should convert a given table with a m:n relation to a light speed entity definition" do
      @light_speed_entity_generator.stubs(:to_light_speed_meta_data).returns(ls_metadata_belongs_to)
      @light_speed_entity_generator.stubs(:foreign_keys).returns(ls_metadata_through_associations_foreign_keys)
      @light_speed_entity_generator.namespace = "LightSpeed.RubyTest"
      
      entities = @light_speed_entity_generator.generate_entities
      
      entities.size.should == 1
      entities[0].properties.size.should == 3
      assert_through_association_entities entities
    end
    
    it "should convert a given table with a 1:m relation to a light speed entity definition" do
      @light_speed_entity_generator.stubs(:to_light_speed_meta_data).returns(ls_metadata_belongs_to)
      @light_speed_entity_generator.stubs(:foreign_keys).returns(ls_metadata_has_many_foreign_keys)
      @light_speed_entity_generator.namespace = "LightSpeed.RubyTest"
      
      entities = @light_speed_entity_generator.generate_entities
      
      entities.size.should == 1
      entities[0].properties.size.should == 3
      assert_has_many_entities entities
    end
    
    it "should convert a given table with a m:1 relation to a light speed entity definition" do
      @light_speed_entity_generator.stubs(:to_light_speed_meta_data).returns(ls_metadata_belongs_to)
      @light_speed_entity_generator.stubs(:foreign_keys).returns(ls_metadata_belongs_to_foreign_keys)
      @light_speed_entity_generator.namespace = "LightSpeed.RubyTest"
      
      entities = @light_speed_entity_generator.generate_entities
      
      entities.size.should == 1
      entities[0].properties.size.should == 3
      assert_belongs_to_entities entities
    end
    
    it "should convert a given table without relations to a light speed entity definition" do
      @light_speed_entity_generator.stubs(:to_light_speed_meta_data).returns(ls_metadata_no_relations)
      @light_speed_entity_generator.stubs(:collect_has_many_relations).returns([])
      @light_speed_entity_generator.stubs(:collect_through_associations).returns([])
      @light_speed_entity_generator.namespace = "LightSpeed.RubyTest"
      
      entities = @light_speed_entity_generator.generate_entities
      entities.size.should == 1
      entities[0].properties.size.should == 2
      assert_entities entities
    end
    
    it "should convert a given table to light speed metadata" do 
      table = {:name => "test_tables"}

      @light_speed_entity_generator = LightSpeedRepository.new
      @light_speed_entity_generator.stubs(:tables).returns([table])
      @light_speed_entity_generator.stubs(:column_info_for).returns(column_infos)
      @light_speed_entity_generator.stubs(:primary_key?).returns(false)
      @light_speed_entity_generator.stubs(:foreign_key?).returns(false)
      @light_speed_entity_generator.stubs(:belongs_to_relation?).returns(false)

      result = @light_speed_entity_generator.to_light_speed_meta_data

      result.should_not be_empty
      result[0][:table_name].should eql(table[:name])
      result[0][:class_name].should eql("TestTable")
      result[0][:fields].size.should eql(2)
      result[0][:fields].each_index do |i|
        result[0][:fields][i][:name].should == column_infos[i][:name]
        result[0][:fields][i][:sql_type].should == column_infos[i][:sql_type]
        result[0][:fields][i][:max_length].should == column_infos[i][:max_length]
        result[0][:fields][i][:nullable].should == !column_infos[i][:is_nullable].to_i.zero?
        result[0][:fields][i][:precision].should == column_infos[i][:precision]
        result[0][:fields][i][:foreign_key].should be_false
        result[0][:fields][i][:primary_key].should be_false
        
        result[0][:fields][i][:unique].should == !column_infos[i][:is_unique].to_i.zero?
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
        { :table_name => "test_tables", :child_id => "test_foreign_key", :parent_table => "test_parent_tables", :parent_id => "test_id" },
        { :table_name => "test_tables", :child_id => "test_foreign_key_2" },
        { :table_name => "other_test_tables", :child_id => "test_foreign_key", :parent_table => "test_parent_tables", :parent_id => "test_id" },
        { :table_name => "test_tables", :child_id => "test_foreign_key", :parent_table => "other_test_parent_tables", :parent_id => "test_id" },
        { :table_name => "test_tables", :child_id => "test_foreign_key", :parent_table => "another_test_parent_tables", :parent_id => "test_id" },
        { :table_name => "other_test_tables", :child_id => "test_foreign_key", :parent_table => "other_test_parent_tables", :parent_id => "test_id" }
      ]
    end
    
    def column_infos
      [
        {:name => "test_id", :sql_type => 'int', :max_length => 4, :is_nullable => '0', :precision => nil, :table_name => "test_parent_tables", :is_unique => "1"},
        {:name => "test_name", :sql_type => 'string', :max_length => 255, :is_nullable => "1", :precision => nil, :table_name => "test_parent_tables", :is_unique => "0"}
      ]
    end
    
    def ls_metadata_belongs_to_foreign_keys
      [ { :table_name => "test_contacts", :child_id => "contact_type_id", :parent_table => "contact_types", :parent_id => "id" } ]
    end
    
    def ls_metadata_has_many_foreign_keys
      ls_metadata_belongs_to_foreign_keys << { :table_name => "contact_notes", :child_id => "test_contact_id", :parent_table => "test_contacts", :parent_id => "id" }
    end
    
    def ls_metadata_through_associations_foreign_keys
      ls_metadata_has_many_foreign_keys << { :table_name => "contact_notes", :child_id => "contact_note_type_id", :parent_table => "contact_note_types", :parent_id => "id" }
    end
    
    def ls_metadata_no_relations
      [{
        :table_name => "test_contacts", 
        :class_name => "TestContact", 
        :fields => [
                    {
                      :name => "id",
                      :sql_type => "int",
                      :max_length => 4,
                      :nullable => false,  
                      :precision => nil,
                      :foreign_key => false,
                      :primary_key => true,
                      :unique => true
                    },
                    {
                      :name => "name",
                      :sql_type => "string",
                      :max_length => 100,
                      :nullable => false,  
                      :precision => nil,
                      :foreign_key => false,
                      :primary_key => false,
                      :unique => true
                    },
                    {
                      :name => "company_name",
                      :sql_type => "string",
                      :max_length => 100,
                      :nullable => true,  
                      :precision => nil,
                      :foreign_key => false,
                      :primary_key => false,
                      :unique => false
                    }
                  ]
      }]
    end
    
    def ls_metadata_belongs_to
      md = ls_metadata_no_relations
      md[0][:fields] << {
        :name => "contact_type_id",
        :sql_type => "int",
        :max_length => 4,
        :nullable => false,  
        :precision => nil,
        :foreign_key => true,
        :primary_key => false,
        :unique => false
      }
      
      md
    end
    
    def assert_entities(entities)
      entities[0].namespace.should == "LightSpeed.RubyTest"
      entities[0].name.should == "TestContact"
      entities[0].properties[0].name.should == "Name"
      entities[0].properties[0].sql_type.should == "string"
      entities[0].properties[0].should_not be_nullable
      entities[0].properties[0].should be_unique
      entities[0].properties[0].max_length.should == 100
      entities[0].properties[0].should_not be_primary_key
      entities[0].properties[0].should_not be_foreign_key
      entities[0].properties[0].precision.should be_nil
      entities[0].properties[1].name.should == "CompanyName"
      entities[0].properties[1].sql_type.should == "string"
      entities[0].properties[1].should be_nullable
      entities[0].properties[1].should_not be_unique
      entities[0].properties[1].max_length.should == 100
      entities[0].properties[1].should_not be_primary_key
      entities[0].properties[1].should_not be_foreign_key
      entities[0].properties[1].precision.should be_nil
    end
    
    def assert_belongs_to_entities(entities)
      assert_entities entities
      entities[0].properties[2].name.should == "ContactTypeId"
      entities[0].properties[2].sql_type.should == "int"
      entities[0].properties[2].max_length.should == 4
      entities[0].properties[2].precision.should be_nil
      entities[0].properties[2].should_not be_nullable
      entities[0].properties[2].should_not be_unique
      entities[0].properties[2].should_not be_primary_key
      entities[0].properties[2].should be_foreign_key
      entities[0].belongs_to.size.should == 1
      entities[0].belongs_to[0][:class_name].should == "ContactType"
      entities[0].belongs_to[0][:name].should == "ContactType"
    end
    
    def assert_has_many_entities(entities)
      assert_belongs_to_entities entities
      entities[0].has_many.size.should == 1
      entities[0].has_many[0][:class_name].should == "ContactNote"
      entities[0].has_many[0][:name].should == "ContactNotes"
    end
    
    def assert_through_association_entities(entities)
      assert_has_many_entities entities
      entities[0].through_associations.size.should == 1
      entities[0].through_associations[0][:class_name].should == "ContactNoteType"
      entities[0].through_associations[0][:name].should == "ContactNoteTypes"
    end
    
end

