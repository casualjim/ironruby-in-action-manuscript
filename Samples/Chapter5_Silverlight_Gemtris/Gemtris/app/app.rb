require 'silverlight'
require 'lib/gemtris'

class App < SilverlightApplication
  use_xaml
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    game = Gemtris::GameManager.new @root.boardGrid
    # Redirect key presses to the game key_handler method
    @root.key_down { |sender, args| game.send :key_handler, sender, args }
    game.start
  end
    
end

$app = App.new
