# The game board
#
class Gemtris::Board

  # Constants for board width & height
  ROWS = 16
  COLUMNS = 10

  # Store the state of the board as a 2D array of Gemtris::Gem's
  #attr_accessor :state

  def initialize(options)
    @board = options[:board]
    @rows, @cols = options[:rows] || ROWS, options[:columns] || COLUMNS
    setup_grid
    reset
  end

  # Set up the grid to have the right number of rows and columns
  #
  def setup_grid
    @rows.times { @board.row_definitions << RowDefinition.new }
    @cols.times { @board.column_definitions << ColumnDefinition.new }
  end

  # Set up our game board to a blank state, ready for a new game of Gemtris
  #
  def reset
    # Remove any previously added Gems from the board
    @board.children.clear
    @rows.times { |i| add_blank_row(i) }
  end
  
  def add_blank_row(row_index)
    @cols.times do |col_index|
      gem_block = Gemtris::Gem.new
      Grid.set_row(gem_block, row_index)
      Grid.set_column(gem_block, col_index)
      gem_block.color = Colors.black
      
      # Testing events
      gem_block.MouseLeftButtonDown do |sender, e|
        sender.color = Colors.red
      end
      
      @board.children << gem_block
    end
  end
  
  # Checks if a block shape shape will collide with another block at the 
  # specified board coordinates
  #
  def will_shape_collide?(shape, x, y)
    true
  end
  
end