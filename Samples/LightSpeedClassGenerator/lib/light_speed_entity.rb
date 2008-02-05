# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 

class LightSpeedEntity
  attr_accessor :properties, :belongs_to, :has_many, :through_associations, :name, :name_space


  def initialize
    @properties = []
    @belongs_to = []
    @has_many = []
    @through_associations =[]
  end
  
  
end
