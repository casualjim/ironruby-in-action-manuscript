require 'silverlight'
require 'lib/gemtris'

class App < SilverlightApplication
  use_xaml
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    board = Gemtris::Board.new :grid => @root.boardGrid, :rows => 16, :columns => 10

    board.state[0][15] = 1
    board.state[1][15] = 1
    board.state[2][15] = 1
    board.state[2][14] = 1

    board.state[5][15] = 2
    board.state[6][15] = 2
    board.state[5][14] = 2
    board.state[6][14] = 2
    
    board.draw
  end
    
end

$app = App.new
