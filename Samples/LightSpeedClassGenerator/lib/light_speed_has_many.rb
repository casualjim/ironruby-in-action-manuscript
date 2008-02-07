require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedHasMany < LightSpeedPropertyBase
  
  
  def to_field(tabindex)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}private readonly EntityCollection<#{class_name}> _#{name.pascalize} = new EntityCollection<#{class_name}>();\n"
  end
  
  def to_property(tabindex)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}public EntityCollection<#{class_name}> #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return Get(_#{name.pascalize}); }\n#{tabs}}\n"
        
  end
  
end