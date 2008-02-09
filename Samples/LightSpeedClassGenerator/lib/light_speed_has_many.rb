require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedHasMany < LightSpeedPropertyBase
  
  def initialize(params = {})
    super
   
  end
    
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}private readonly EntityCollection<#{class_name}> _#{name.camelcase} = new EntityCollection<#{class_name}>();\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}public EntityCollection<#{class_name}> #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return Get(_#{name.camelcase}); }\n#{tabs}}\n"
        
  end
  
end