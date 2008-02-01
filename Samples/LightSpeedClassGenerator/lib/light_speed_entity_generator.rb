

class LightSpeedEntityGenerator

  include DB::MetaData

  def initialize
    super
  end

  def generate_classes
    tables.collect do |table|
      table.classify
    end
  end
  

end  
  
