class Array
  
  def has_property?(name)
    exists = false
    
    each do |hm|
      exists = hm[:name] == name
      break if exists
    end
    
    exists
  end
end

class LightSpeedEntity
  attr_accessor :properties, :belongs_to, :has_many, :through_associations, :name, :namespace, :pk_type


  def initialize
    @properties = []
    @belongs_to = []
    @has_many = []
    @through_associations =[]
  end
  
  def create_property_name_from(from, idx=0)
    tname = build_property_name_from from, idx
    idx += 1 #when the property exists try with a higher number
    return create_property_name_from(from, idx) if has_property?(tname)
    tname
  end
  
  def has_through_associations?
    @through_associations.size > 0
  end
  
  private
    
    def has_property?(tname)
      properties.has_property? tname or has_many.has_property? tname or belongs_to.has_property? tname or through_associations.has_property? tname
    end
  
    def build_property_name_from(from, idx)
      if idx == 0
        from
      else
        "#{from}#{idx}"
      end
    end
  
  
end
