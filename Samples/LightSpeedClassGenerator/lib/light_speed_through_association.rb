require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedThroughAssociation < LightSpeedPropertyBase
  
  def initialize(params = {})
    super
  end
  
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}private readonly ThroughAssociation<#{through}, #{class_name}> _#{name.camelcase};\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}public ThroughAssociation<#{through}, #{class_name}> #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget\n#{tabs}\t{\n"
    result << "#{tabs}\t\tif(_#{name.camelcase} == null)\n"
    result << "#{tabs}\t\t\t_#{name.camelcase} = new ThroughAssociation<#{through}, #{class_name}>(#{dependant_name});\n"
    result << "#{tabs}\t\treturn Get(_#{name.camelcase}); }\n#{tabs}}\n"
        
  end
  
end