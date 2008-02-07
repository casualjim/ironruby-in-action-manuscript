require File.dirname(__FILE__) + "/string"
class LightSpeedPropertyBase
  
  attr_accessor :attributes
  
  def initialize(params = {})
    @attributes = params
    LightSpeedProperty.create_methods params
    
  end
  
  def [](attribute)
    attributes[attribute]
  end
  
  
  
  def clr_type
    
  end
  
  def self.create_methods(params)
    
    params.each do |k, v|
      define_method("#{k}=") do |val|
        @attributes[k]= val
      end
      
      predicate = %w(primary_key foreign_key unique nullable belongs_to).any? { |o| o === k.to_s }
      
      define_method(predicate ? "#{k}?" : "#{k}") do
        @attributes[k]
      end
      
    end
  end
  
  private
    
    def validate_presence_attribute
      if responds_to? :belongs_to?
        belongs_to? ? "#{tabs}[Dependent(ValidatePresence = true)]" : "#{tabs}[ValidatePresence]\n"
      else
        "#{tabs}[ValidatePresence]\n"
      end
    end
  

end