require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedThroughAssociation < LightSpeedPropertyBase
  
  def initialize(params = {})
    super
  end
  
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex -1) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}private ThroughAssociation<#{through}, #{class_name}> _#{name.camelcase(:lower)};\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex -1) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}public virtual ThroughAssociation<#{through}, #{class_name}> #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget\n#{tabs}\t{\n"
    result << "#{tabs}\t\tif(_#{name.camelcase(:lower)} == null)\n"
    result << "#{tabs}\t\t\t_#{name.camelcase(:lower)} = new ThroughAssociation<#{through}, #{class_name}>(#{dependant_name});\n"
    result << "#{tabs}\t\treturn Get(_#{name.camelcase(:lower)}); }\n#{tabs}\n}\n"
        
  end
  
end