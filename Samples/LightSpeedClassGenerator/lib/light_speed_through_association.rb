require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedThroughAssociation < LightSpeedPropertyBase
  
  
  def to_field(tabindex)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}private readonly ThroughAssociation<#{through}, #{class_name}> _#{name.pascalize};\n"
  end
  
  def to_property(tabindex)
    tabs = ""
    result = ""
    tabindex.times { tabs << "\t" }
    
    result << "#{tabs}public ThroughAssociation<#{through}, #{class_name}> #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget\n#{tabs}\t{\n"
    result << "#{tabs}\t\tif(_#{name.pascalize} == null)\n"
    result << "#{tabs}\t\t\t_#{name.pascalize} = new ThroughAssociation<#{through}, #{class_name}>(#{dependant_name});\n"
    result << "#{tabs}\t\treturn Get(_#{name.pascalize}); }\n#{tabs}}\n"
        
  end
  
end