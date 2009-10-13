$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.dirname(__FILE__) + '/magic/lib'

require 'wpf'
require 'wpf_toolkit'
require 'magic'

# a little model

class Item
  attr_accessor :name, :price
  
  def initialize(name, price)
    @name = name.to_clr_string # without to_clr_string, the string appears empty (no clear explanation right now)
    @price = price
  end
end

# create some data

data = []
data << Item.new("Orange",2.3)
data << Item.new("Apple",2.1)
data << Item.new("Ham", 3.90)

# then build the UI

window = Magic.build do
  window(:title => "Some fruits using the WPF Toolkit DataGrid") do
    data_grid(:items_source => data)
  end
end

Application.new.run(window)