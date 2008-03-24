require File.dirname(__FILE__) + "/light_speed_property_base"
class LightSpeedProperty < LightSpeedPropertyBase
  def initialize(params = {})
    super
  end
  
  
  def to_field(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" }
    
    result << validate_presence_attribute(tabs) unless nullable?
    result << "#{tabs}[ValidateUnique]\n" if unique?
    result << "#{tabs}private #{clr_type} _#{name.camelcase};\n"
  end
  
  def to_property(tabindex = 0)
    tabs = ""
    result = ""
    0.upto(tabindex) { tabs << "\t" }
    
    result << "#{tabs}public #{clr_type} #{name}\n"
    result << "#{tabs}{\n#{tabs}\tget { return _#{name.camelcase}; }\n"
    result << "#{tabs}\tset { _#{name.camelcase} = value; }\n#{tabs}}\n"
  end
  
  def clr_type
    DB::DbiSqlServer.to_clr_type sql_type
  end
  
  private
    
    def validate_presence_attribute(tabs)
      foreign_key? ? "#{tabs}[Dependent(ValidatePresence = true)]" : "#{tabs}[ValidatePresence]\n"
    end
  
end
