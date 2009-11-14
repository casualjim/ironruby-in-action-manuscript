# The game board
#
class Gemtris::Board

  # Constants for board width & height
  #ROWS = 16
  #COLS = 10

  # Store the state of the board as a 2D array of Gemtris::Gem's
  #attr_accessor :state

  def initialize(options)
    @rows, @cols = options[:rows], options[:columns]
    setup_grid
    reset
  end

  # Set up the grid to have the right number of rows and columns
  #
  def setup_grid
    rows.times { self.row_definitions << RowDefinition.new }
  end

  # Set up our game board to a blank state, ready for a new game of Gemtris
  #
  def reset
    # Remove any previously added Gems from the board
    self.children.clear
    
    @rows.times { add_blank_top_row }
  end
  
  def add_blank_top_row
    @cols.times do |col|
      gem_block = Gemtris::Gem.new
      self.children << gem_block
    end
  end
  
  # Checks if a block shape shape will collide with another block at the 
  # specified board coordinates
  #
  def will_shape_collide?(shape, x, y)
    true
  end
  
end