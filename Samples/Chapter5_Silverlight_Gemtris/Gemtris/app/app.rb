require 'silverlight'
require 'lib/gemtris'

class App
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    
    # Define the options config hash for our game of Gemtris
    options = { 
      :speed => 400, 
      :speed_up => 10, 
      :sounds => { 
        :gem_placed => @root.sndGem, 
        :line_completed => @root.sndLine 
      } 
    }
    # Create a new game of Gemtris
    game = Gemtris::GameManager.new(@root.boardGrid, @root.nextShape, @root.completedLinesCount, options) 
    
    # Redirect key presses to the game key_handler method
    @root.key_down { |sender, args| game.handle_key_press args.key.to_s.downcase.to_sym }
    
    @root.start_button.click do |sender, e| 
     game.start 
     sender.visibility = Visibility.collapsed
    end
    
    #CompositionTarget.rendering do |sender, e|
    #  raise "#{sender}"
    #end
  end

end

$app = App.new
