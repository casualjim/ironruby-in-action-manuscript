require "pp"
require File.dirname(__FILE__) + "/meta_data"
require File.dirname(__FILE__) + "/string"
require File.dirname(__FILE__) + "/light_speed_entity"
require File.dirname(__FILE__) + "/light_speed_property"
require File.dirname(__FILE__) + "/light_speed_belongs_to"
require File.dirname(__FILE__) + "/light_speed_has_many"
require File.dirname(__FILE__) + "/light_speed_through_association"
class LightSpeedRepository

  include DB::MetaData
  
  attr_reader :entities
  attr_accessor :namespace
  

  def initialize()
    @entities = []
    super
  end
  
  def to_light_speed_meta_data
    tables.collect do |table|
      col_infos = column_info_for table[:name]
      
      field_infos = col_infos.collect do |col_info|
        {
          :name => col_info[:name].underscore,
          :sql_type => col_info[:sql_type],
          :max_length => col_info[:max_length].to_i,
          :nullable => !col_info[:is_nullable].to_i.zero?,  
          :precision => col_info[:precision],
          :foreign_key => foreign_key?(col_info),
          :primary_key => primary_key?(col_info),
          :unique => !col_info[:is_unique].to_i.zero?,
          :belongs_to => belongs_to_relation?(table[:name], col_info)
        }
      end
      
      { :table_name => table[:name], :class_name => table[:name].singularize.camelize, :fields => field_infos }
    end
  end
  
  def generate_entities
    meta_data = to_light_speed_meta_data
    meta_data.each do |md|
      @entities << generate_entity(md)
    end
    @entities
  end
  
  def generate_entity(meta_data)
    entity = LightSpeedEntity.new
    entity.name = meta_data[:class_name]
    entity.namespace = namespace

    meta_data[:fields].each do |fi|
      prop = LightSpeedProperty.new(fi)
      
      prop.name = entity.create_property_name_from prop.name.underscore.camelize
      entity.pk_type = prop.clr_type if prop.primary_key?
      entity.properties << prop unless prop.primary_key?
      entity.belongs_to << LightSpeedBelongsTo.new(generate_belongs_to_relation(meta_data, fi, entity)) if prop.foreign_key?

    end
    
    entity.has_many = generate_has_many_relations meta_data, entity
    generate_through_associations meta_data, entity
    
    entity
  end
  
 
  def conventionalized?
     result = true
     tables.each do |table|
       pks = primary_keys_for table[:name]
       result = (pks.size == 1 and pks[0][:column_name] == "Id") if result
     end
     result
  end

  
  private
  
    def generate_belongs_to_relation(meta_data, field_info, entity)
      { 
        :name => entity.create_property_name_from(field_info[:name].underscore.humanize.titleize.gsub(/\s/,'')), 
        :class_name => get_belongs_to_table(meta_data[:table_name], field_info[:name]).underscore.camelize.singularize
      }
    end
  
    def generate_has_many_relations(meta_data, entity)
      hms = collect_has_many_relations meta_data[:table_name]
      hms.collect do |hm|
         hm[:name] = entity.create_property_name_from hm[:class_name].pluralize
         LightSpeedHasMany.new hm
      end
      
    end
    
    def generate_through_associations(meta_data, entity)
      tas = collect_through_associations(meta_data[:table_name]) 
      tas.each do |ta|
        ta[:end_tables].each do |et|
          entity.through_associations << LightSpeedThroughAssociation.new(generate_through_association(ta, et, entity))
        end
      end
    end
    
    def generate_through_association(association, end_table, entity)
      {
        :through => association[:through_table].classify.singularize, 
        :class_name => end_table.camelize.singularize, 
        :name => entity.create_property_name_from(end_table.camelize),
        :dependant_name => entity.create_property_name_from(association[:through_table].pascalize)
      }
    end


    
  
  # def conventionalize
  #     unless conventionalized?
  #       
  #       tables.each do |table|
  #         @db.execute_non_query build_sql_string_for(table)
  #       end
  #       
  #       populate
  #     end
  #   end  
  
# require 'config/boot'
# ls = LightSpeedRepository.new
# ls.conventionalize_database
  
  # private 
  
    # def build_sql_string_for(table)
    #       pks = primary_keys_for table[:name]
    #       sql =""
    #       case pks.size 
    #       when 0
    #         sql = add_primary_key_to(table[:name])
    #       when 1
    #         sql = "EXECUTE sp_rename N'dbo.#{table[:name]}.#{pks[0][:column_name]}', N'Id', 'COLUMN' " unless pks[0][:column_name] == "Id"
    #       else
    #         sql = migrate_to_single_primary_key(table[:name], pks)
    #       end
    #                 
    #       sql
    #     end
    #   
    #     
    #     
    #     def migrate_to_single_primary_key(table, pks)
    #       sql = ""
    #       pks.collect { |pk| pk[:index_name]  }.uniq!.each do |index|
    #         sql << "ALTER TABLE dbo.#{table} DROP CONSTRAINT #{index}\n"
    #       end
    #       sql << add_primary_key_to(table)
    #       sql
    #     end
    #     
    #     def add_primary_key_to(table)
    #       sql = "ALTER TABLE dbo.#{table} ADD Id uniqueidentifier NOT NULL ROWGUIDCOL;\n"
    #       sql << add_primary_key_constraints_to(table)
    #       sql
    #     end
    #     
    #     def add_primary_key_constraints_to(table)
    #       "ALTER TABLE dbo.#{table} ADD CONSTRAINT DF_#{table}_Id DEFAULT (newid()) FOR Id
    #         ALTER TABLE dbo.#{table} ADD CONSTRAINT PK_#{table} PRIMARY KEY CLUSTERED(Id) WITH( 
    #           STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
    #         ) ON [PRIMARY]"
    #     end

end  
  
