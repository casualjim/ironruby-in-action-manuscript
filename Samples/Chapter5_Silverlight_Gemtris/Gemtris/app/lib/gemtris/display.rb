# The game board
#
class Gemtris::Display
  
  # A buffer for a new shape to be positioned in the state array
  SHAPE_BUFFER_HEIGHT = 4
  
  # Constants for board width & height
  DEFAULT_HEIGHT = 16
  DEFAULT_WIDTH = 10
  
  attr_reader :current_shape, :state, :buffer_height
  attr_accessor :width, :height

  def initialize(options)
    @board_grid = options[:grid]
    @height, @width = options[:height] || DEFAULT_HEIGHT, options[:width] || DEFAULT_WIDTH
    @buffer_height = options[:buffer_height] || SHAPE_BUFFER_HEIGHT
    reset
  end

  def reset
    @current_shape = nil
    init_grid
    init_state_array
  end

  # Set up the grid to have the right number of rows and columns
  #
  def init_grid
    # remove any existing children from the XAML Grid element
    @board_grid.children.clear
    
    # add column definitions
    @width.times { @board_grid.column_definitions << ColumnDefinition.new }
    
    # add row definitions and blank rows of gems
    @height.times do |row_index| 
      @board_grid.row_definitions << RowDefinition.new 
      @width.times do |col_index|
        # Create a new Gem control and configure it as blank
        gem_block = Gemtris::Gem.new
        gem_block.visibility = Visibility.collapsed
        # Position the gem in the Grid control
        Grid.set_row(gem_block, row_index)
        Grid.set_column(gem_block, col_index)
        # Add the Gem to the Grid
        @board_grid.children << gem_block
      end
    end
  end

  # Create a 2D array to store the game state. This array is inspected for values 
  # when rendering the game board in the draw method.
  #
  def init_state_array
    @state = Array.new(@height + @buffer_height) { Array.new(@width) { 0 } }
  end
  
  def set_state_at(x, y, state)
    @state[@buffer_height+y][x] = state
  end
  
  def state_at(x,y)
    @state[@buffer_height+y][x]
  end

  # Return a Gem object at a cell
  #
  def gem_at(x,y)
    x = x % @width
    y = y % @height
    @board_grid.children[(y * @width) + x]
  end
  
  def set_current_shape(shape=nil)
    @current_shape = shape || Gemtris::Shape.new(self)
  end

  # Clear the display
  #
  def clear
    @height.times do |row|
      @width.times do |col|
        g = gem_at(col, row)
        g.hide
      end
    end
  end
  
  # Render the state array to the board, as well as the boards current shape
  #
  def draw
    clear
    @current_shape.draw
  end
  
end