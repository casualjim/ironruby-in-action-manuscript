require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedBelongsTo < LightSpeedPropertyBase
  
  def initialize(params = {})
    super
  end
  
  
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}private EntityHolder<#{class_name}> _#{name.camelcase} = new EntityHolder<#{class_name}>();\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}public #{class_name} #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return Get(_#{name.camelcase}); }\n"
    result << "#{tabs}\tset { Set(_#{name.downcase}) = value; }\n#{tabs}}\n"
        
  end
  
end