require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedProperty < LightSpeedPropertyBase
  
  
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << validate_presence_attribute unless nullable?
    result << "#{tabs}[ValidateUnique]\n" if unique?
    result << "#{tabs}private #{clr_type} _#{name.pascalize};\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}public #{clr_type} #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return _#{name.pascalize}; }\n"
    result << "#{tabs}\tset { _#{name.pascalize} = value; }\n#{tabs}}\n"
  end
  
end