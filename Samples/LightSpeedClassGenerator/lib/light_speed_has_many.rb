require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedHasMany < LightSpeedPropertyBase
  
  def initialize(params = {})
    super
   
  end
  
  def should_generate?(user_file_content)
    Regexp.compile("EntityCollection<#{class_name}>\s+_#{name.camelcase(:lower)}").match(user_file_content).nil?
  end
  
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex-1) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}private readonly EntityCollection<#{class_name}> _#{name.camelcase(:lower)} = new EntityCollection<#{class_name}>();\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex-1) { tabs << "\t" } if tabindex > 0
    
    result << "#{tabs}public virtual EntityCollection<#{class_name}> #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return Get(_#{name.camelcase(:lower)}); }\n#{tabs}}\n"
        
  end
  
end