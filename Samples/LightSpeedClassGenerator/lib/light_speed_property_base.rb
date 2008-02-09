require File.dirname(__FILE__) + "/string"
class LightSpeedPropertyBase
  
  attr_accessor :attributes
  
  def initialize(params = {})
    @attributes = params
    LightSpeedPropertyBase.create_methods params
  end
  
  def [](attribute)
    attributes[attribute]
  end
  
  
  
   
  def self.create_methods(params)
    
    params.each do |k, v|
      define_method("#{k}=") do |val|
        @attributes[k]= val
      end
      
      predicate = %w(primary_key foreign_key unique nullable).any? { |o| o === k.to_s }
      method_name = predicate ? "#{k}?" : "#{k}"
      define_method(method_name) do
        @attributes[k]
      end
      
    end
  end
  


end