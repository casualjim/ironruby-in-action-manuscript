require 'silverlight'
require 'lib/gemtris'

class App < SilverlightApplication
  use_xaml
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    
    @boardGrid = @root.boardGrid
    Gemtris::Board.new :board => @root.boardGrid, :rows => 16, :columns => 10
  end
    
end

$app = App.new
