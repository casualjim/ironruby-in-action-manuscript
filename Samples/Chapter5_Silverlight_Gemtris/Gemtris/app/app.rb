require 'silverlight'
require 'lib/gemtris'

class App < SilverlightApplication
  use_xaml
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    @root.find_name('message').text = "Retris"
    myGem = @root.myGem
    myGem.fill=(Colors.Purple)
    
    
    #@board = @root.find_name('board')
  end
    
end

$app = App.new
