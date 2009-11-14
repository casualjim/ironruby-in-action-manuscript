require 'silverlight'
require 'lib/gemtris'

class App < SilverlightApplication
  use_xaml
  
  def initialize
    @root = Application.current.load_root_visual(UserControl.new, "app.xaml")
    #@root.find_name('message').text = "Retris"
    
    @boardGrid = @root.boardGrid
    16.times do |r|
      10.times do |c|
        g = Gemtris::Gem.new
        Grid.set_row(g, r)
        Grid.set_column(g, c)
        g.margin = System::Windows::Thickness.new 1
        @boardGrid.children.add g
      end
    end
    
    #@board = @root.find_name('board')
  end
    
end

$app = App.new
