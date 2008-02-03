class LightSpeedProperty
  
  attr_accessor :attributes
  
  def initialize(params)
    @attributes = params
    
    params.each do |k, v|
      define_method("#{k}") do
        @attributes[k]
      end
      
      define_method("#{k}=") do |val|
        @attributes[k]= val
      end
    end
  end
  

end