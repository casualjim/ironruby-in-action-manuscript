# The game board
#
class Gemtris::Board

  # Constants for board width & height
  DEFAULT_HEIGHT = 16
  DEFAULT_WIDTH = 10
  
  # A buffer for a new shape to be positioned in the state array
  SHAPE_BUFFER_HEIGHT = 4
  
  attr_reader :completed_row_count, :current_shape
  attr_accessor :width, :height

  def initialize(options)
    @board_grid = options[:grid]
    @height, @width = options[:rows] || DEFAULT_HEIGHT, options[:columns] || DEFAULT_WIDTH

    reset
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
    @state = Array.new(@height + SHAPE_BUFFER_HEIGHT) { Array.new(@width) { 0 } }
  end
  
  # Set up our game board to a blank state, ready for a new game of Gemtris
  #
  def reset
    init_state_array
    init_grid
    
    @completed_row_count = 0
    
    # pre-initialise the board with a new shape, ready to drop in
    add_new_shape
  end
  
  def set_state_at(x, y, state)
    @state[SHAPE_BUFFER_HEIGHT+y][x] = state
  end
  
  def state_at(x,y)
    @state[SHAPE_BUFFER_HEIGHT+y][x]
  end
  
  # Return a Gem object at a cell
  #
  def gem_at(x,y)
    x = x % @width
    y = y % @height
    @board_grid.children[(y * @width) + x]
  end
  
  # Render the state array to the board, as well as the boards current shape
  #
  def draw
    @height.times do |row|
      @width.times do |col|
        pos_state = state_at(col, row)
        g = gem_at(col, row)
        
        case pos_state
        when 0:
          g.visibility = Visibility.collapsed
          g.color = Colors.black
        else
          shape_defn = Gemtris::Shape::SHAPES[pos_state]
          if(shape_defn.nil?)
            raise "A shape was expected, but found nil"
          end
          g.visibility = Visibility.visible
          g.color = shape_defn[:color]
        end
      end
    end
    
    @current_shape.draw
  end
  
  def add_new_shape(shape=nil)
    @current_shape = shape || Gemtris::Shape.new(self)
  end
  
  def remove_completed_rows
    # Go from bottom up
    row = @height - 1
    while row > 0
      completed = true
      @width.times do |col|
        completed &= state_at(col, row) != 0
      end
      if completed
        @completed_row_count += 1
        @state.slice!(SHAPE_BUFFER_HEIGHT + row)
        @state.unshift Array.new(@width)
      else
        row -= 1 # next row up
      end
    end
  end
  
end