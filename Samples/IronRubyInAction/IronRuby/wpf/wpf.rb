require 'mscorlib'
require 'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' 
require 'System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'PresentationFramework, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'PresentationCore, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'

include System
include System::Windows
include System::Windows::Controls
include System::Windows::Markup
include System::Windows::Media
include System::Windows::Media::Animation

module Wpf
  module Builders
    def name_collector
      @___name_collector_ 
    end

    def [](name)
      name_collector[name]
    end

    def inject_names(obj)
      name_collector.each_pair { |k, v| obj.instance_variable_set("@#{k}".to_sym, v) }
    end

    def evaluate_properties(obj, args, &b) 
      obj.instance_variable_set(:@___name_collector_, name_collector)
      name_collector.each_pair { |k, v| puts k }
      args.each_pair do |k, v|         
        if k == :name 
          name_collector[v] = obj
        end
        obj.send :"#{k.to_s}=", v
      end
      
      if obj.respond_to? :name
        name_collector[obj.name] = obj unless obj.name.nil?
      end

      obj
    end

    def add_object_to_name_collector(collection, obj, args = {}, &b)
      obj = evaluate_properties(obj, args, &b)
      obj.instance_eval(&b) unless b.nil?
      collection.add obj
      obj
    end
    
    def add_class_to_name_collector(collection, klass, args = {}, &b)
      obj = evaluate_properties(klass.new, args, &b)
      obj.instance_eval(&b) unless b.nil?
      collection.add obj
      obj
    end    

    def assign_to_name_collector(property, klass, args = {}, &b) 
      obj = evaluate_properties(klass.new, args, &b)
      obj.instance_eval(&b) unless b.nil?
      self.send property, obj
      obj
    end
    
  end
  
  module ChildrenBuilder
    def add(klass, args = {}, &b)
      add_class_to_name_collector(children, klass, args, &b)
    end

    def add_name(name, obj)
      name_collector[name] = obj
    end

    def add_obj(obj)
      add_object_to_name_collector(children, obj)
    end  
    
  end
  
  module Dockable
    def dock=(docking)
      DockPanel.set_dock self, case docking
        when :top
          Dock.top
        when :bottom
          Dock.bottom
        when :left
          Dock.left
        when :right
          Dock.right
        end
    end
  end
  

  def self.build(klass, args = {}, &b)
    obj = klass.new
    obj.instance_variable_set(:@___name_collector_, {})

    args.each_pair do |k, v| 
      if k == :name 
        obj.name_collector[v] = obj 
      end
      obj.send :"#{k.to_s}=", v
    end
    
    obj.instance_eval(&b) unless b.nil?
    obj
  end  
  
end


