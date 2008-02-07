require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedBelongsTo < LightSpeedPropertyBase
  
  
  def to_field(tabindex)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}private EntityHolder<#{class_name}> _#{name.pascalize} = new EntityHolder<#{class_name}>();\n"
  end
  
  def to_property(tabindex)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}public #{class_name} #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return Get(_#{name.pascalize}); }\n"
    result << "#{tabs}\tset { Set(_#{name.downcase}) = value; }\n#{tabs}}\n"
        
  end
  
end