require 'rexml/document'

require File.dirname(__FILE__) + "/meta_data"
require File.dirname(__FILE__) + "/string"
require File.dirname(__FILE__) + "/light_speed_entity"
require File.dirname(__FILE__) + "/light_speed_property"
require File.dirname(__FILE__) + "/light_speed_belongs_to"
require File.dirname(__FILE__) + "/light_speed_has_many"
require File.dirname(__FILE__) + "/light_speed_through_association"

class LightSpeedRepository

  include DB::MetaData
  include REXML
  
  attr_reader :entities
  attr_accessor :namespace, :excluded_tables
  
  DEFAULT_REFERENCES = ["System", "Mindscape.LightSpeed", "Mindscape.LightSpeed.Validation"]

  def initialize(project_file_location, namespace, model_path)
    @entities = []
    @project_file_location = project_file_location
    @namespace = namespace || File.basename(project_file_location, ".csproj")
    @model_path = model_path || File.dirname(project_file_location)
    puts "Will append files to #{@project_file_location}"
    puts "Models will be saved to #{@model_path}"
    puts "fetching meta data from the database"
    populate
  end
  
  def to_light_speed_meta_data
    tables.collect do |table|
      
      unless excluded_tables.any?{ |t| t == table[:name] }
        col_infos = column_info_for table[:name]
      
        field_infos = col_infos.collect do |col_info|
          {
            :name => col_info[:name].underscore,
            :sql_type => col_info[:sql_type],
            :max_length => col_info[:max_length].to_i,
            :nullable => col_info[:is_nullable],  
            :precision => col_info[:precision],
            :foreign_key => foreign_key?(col_info),
            :primary_key => primary_key?(col_info),
            :unique => col_info[:is_unique]
          
          }
        end
      
        { :table_name => table[:name], :class_name => table[:name].singularize.classify, :fields => field_infos }
      end
      
    end.compact
  end
  
  def generate_entities
    meta_data = to_light_speed_meta_data
    meta_data.each do |md|
      @entities << generate_entity(md)
    end
    @entities
  end
  
  def generate_entity(md)
    entity = LightSpeedEntity.new
    entity.name = md[:class_name]
    entity.namespace = namespace

    md[:fields].each do |fi|
      prop = LightSpeedProperty.new(fi)
      
      prop.name = entity.create_property_name_from prop.name.underscore.classify
      entity.pk_type = prop.clr_type if prop.primary_key?
      entity.properties << prop unless prop.primary_key?
      entity.belongs_to << LightSpeedBelongsTo.new(generate_belongs_to_relation(md, fi, entity)) if prop.foreign_key?

    end
    
    entity.has_many = generate_has_many_relations md, entity
    generate_through_associations md, entity
    
    entity
  end
  
  def add_files_to_vs_project
    puts "starting to generate files"
    generate_entities
        
    proj_file = File.new(@project_file_location)
    doc = Document.new proj_file
    updates_project_file = false
    @entities.each do |entity|
      updates_project_file = generate_files_for entity unless updates_project_file

      if updates_project_file && !doc.elements.to_a('//Compile').any?{ |e| e.attributes['Include'] === "#{entity.name}.cs"}
        u_el = Element.new "Compile"
        u_el.attributes["Include"] = "#{entity.name}.cs"
        el = Element.new "Compile"
        el.attributes["Include"] = "#{entity.name}.lightspeed.cs"
        dep_el = Element.new "DependentUpon"
        dep_el.text = "#{entity.name}.cs"
        el.add_element dep_el
        unless doc.elements['//Compile'].nil?
          parent = doc.elements['//Compile'].parent
        else
          parent = Element.new "ItemGroup" 
          doc.elements['//Project'] << parent
        end
        parent << u_el
        parent << el

      end
    end
    
    if updates_project_file
      puts "Updating the project file #{@project_file_location}"
      File.open(@project_file_location, 'w+'){ |file| doc.write file }
    end
    true
  end
  
  def generate_files_for(entity)
    generate_file_for entity
    generate_user_stub_file_for entity
  end
  
  def generate_file_for(entity)
    path = "#{@model_path}/#{entity.name}.lightspeed.cs"
    puts "creating lightspeed model file: #{path}"
    File.open(path, 'w') do |f|
      f << create_file_content(entity) do |file_content, tabindex|
        rendered_fields, rendered_properties = "", ""
        
        %w(properties belongs_to has_many through_associations).each do |method|
          entity.send(method.to_sym).each do |prop|
            rendered_fields << prop.to_field(tabindex)
            rendered_properties << prop.to_property(tabindex)
          end
        end
        
        file_content << "#{rendered_fields}\n\n#{rendered_properties}\n\n"
      end
    end
  end
  
  def generate_user_stub_file_for(entity)
    path = "#{@model_path}/#{entity.name}.cs"
    updates_project_file = false
    unless File.exists? path
      puts "creating user stub file: #{path}"
      updates_project_file = true
      File.open(path, 'w+') do |f|
        f << create_file_content(entity)
      end 
    end
    updates_project_file
  end
  
  private
  
    def create_file_content(entity)
      file_content = ""
      
      DEFAULT_REFERENCES.each do |ref|
        file_content << "using #{ref};\n"
      end
      file_content << "using System.Collections.Generic;\n" if entity.has_through_associations?
      
      file_content << "\nnamespace #{entity.namespace}\n{\n"
      file_content << (block_given? ? "\tpublic partial class #{entity.name} : Entity<#{entity.pk_type}>" : "\tpublic partial class #{entity.name}")
      file_content << "\n\t{\n"
      
      yield file_content, 2 if block_given?
     
      file_content << "\t}\n}\n"
    end
  
    def generate_belongs_to_relation(meta_data, field_info, entity)
      { 
        :name => entity.create_property_name_from(field_info[:name].underscore.humanize.titleize.gsub(/\s/,'')), 
        :class_name => get_belongs_to_table(meta_data[:table_name], field_info[:name]).underscore.classify.singularize
      }
    end
  
    def generate_has_many_relations(meta_data, entity)
      hms = collect_has_many_relations meta_data[:table_name]
      hms.collect do |hm|
         hm[:class_name] = hm[:table_name].singularize.underscore.classify
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
        :class_name => end_table.classify.singularize, 
        :name => entity.create_property_name_from(end_table.classify),
        :dependant_name => "_#{association[:through_table].camelcase(:lower)}"
      }
    end

end  
  
