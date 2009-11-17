require 'silverlight'
require 'lib/gemtris'

class App < SilverlightApplication
  use_xaml
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    
    # Create a new game of Gemtris
    game = Gemtris::GameManager.new @root.boardGrid, @root.nextShape, @root.completedLinesCount, { :speed => 400, :speed_up => 10 }
    
    # Redirect key presses to the game key_handler method
    @root.key_down { |sender, args| game.handle_key_press args.key.to_s.downcase.to_sym; @root.sndGem.play }

    # Start the game
    game.start
  end

end

$app = App.new
