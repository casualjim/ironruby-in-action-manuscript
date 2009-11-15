# The game board
#
class Gemtris::Board

  # Constants for board width & height
  ROWS = 16
  COLUMNS = 10
  
  attr_accessor :state

  def initialize(options)
    @board_grid = options[:grid]
    @rows, @cols = options[:rows] || ROWS, options[:columns] || COLUMNS
    @state = []
    
    init_grid
    init_state_array
    reset
  end

  # Set up the grid to have the right number of rows and columns
  #
  def init_grid
    @rows.times { @board_grid.row_definitions << RowDefinition.new }
    @cols.times { @board_grid.column_definitions << ColumnDefinition.new }
  end

  def init_state_array
    @rows.times do |row|
      @state[row] = []
      @cols.times do |col|
        @state[row][col] = 0
      end
    end
  end
  
  # Set up our game board to a blank state, ready for a new game of Gemtris
  #
  def reset
    # Remove any previously added Gems from the board
    @board_grid.children.clear
    @rows.times { |i| add_blank_row(i) }
  end
  
  def add_blank_row(row_index)
    @cols.times do |col_index|
      # Create a new Gem control and configure it as blank
      gem_block = Gemtris::Gem.new
      gem_block.color = Colors.black
      gem_block.visibility = Visibility.collapsed
      # Position the gem in the Grid control
      Grid.set_row(gem_block, row_index)
      Grid.set_column(gem_block, col_index)
      # Add the Gem to the Grid
      @board_grid.children << gem_block
    end
  end
  
  # Return a Gem at a cell
  #
  def cell(x,y)
    @state[x][y]
  end
  
  # Return a Gem object at a cell
  #
  def gem_at(x,y)
    x = x % @cols
    y = y % @rows
    @board_grid.children[(y * @cols) + x]
  end
  
  def draw
    @rows.times do |y|
      @cols.times do |x|
        g, s = gem_at(x,y), cell(x,y)
        
        case s
        when 0:
          g.visibility = Visibility.collapsed
          g.color = Colors.black
        when 1:
          g.visibility = Visibility.visible
          g.color = Colors.red
        when 2:
          g.visibility = Visibility.visible
          g.color = Colors.blue
        when 3:
        when 4:
        when 5:
        when 6:
        end
      end
    end
  end
  
end