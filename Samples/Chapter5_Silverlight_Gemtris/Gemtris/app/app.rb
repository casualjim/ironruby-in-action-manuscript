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
    @game = Gemtris::GameManager.new(@root.boardGrid, @root.nextShape, @root.completedLinesCount, options) 
    
    # There are a couple ways to add events to the start button
    # @root.start_button.click do |sender, e| 
    #  @game.start 
    #  sender.visibility = Visibility.collapsed
    # end
    @root.start_button.click.add method(:start_button_clicked)
  end
  
  def start_button_clicked(sender, args)
    sender.visibility = Visibility.collapsed
    @game.start 
  end

end

$app = App.new
