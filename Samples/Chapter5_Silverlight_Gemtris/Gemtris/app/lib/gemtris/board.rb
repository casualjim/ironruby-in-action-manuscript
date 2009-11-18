# The game board
#
class Gemtris::Board < Gemtris::Display
  
  attr_reader :current_shape

  def initialize(options)
    super options
  end
  
  # Set up our game board to a blank state, ready for a new game of Gemtris
  #
  def reset
    super
    set_current_shape # pre-initialise the board with a new shape, ready to drop in
  end
    
  # Render the state array to the board, as well as the boards current shape
  #
  def draw
    @height.times do |row|
      @width.times do |col|
        g = gem_at(col, row)        
        pos_state = state_at(col, row)
        
        case pos_state
        when 0:
          g.hide
          g.color = Colors.black
        else
          shape_defn = Gemtris::Shape::SHAPES[pos_state]
          if(shape_defn.nil?)
            raise "A shape was expected, but found nil"
          end
          g.show
          g.color = shape_defn[:color]
        end
      end
    end
    
    @current_shape.draw
  end
  
  def remove_completed_rows
    completed_lines_count = 0
    
    # Go from bottom up
    row = @height - 1
    while row > 0
      completed = true
      @width.times do |col|
        completed &= state_at(col, row) != 0
      end
      if completed
        @width.times { |col|  gem_at(col, row).glimmer }
        
        # TODO: Figure out how to pause the game loop thread here, do the glimmer animation
        # wait for all gems to complete animation, then remove the row
        
        completed_lines_count += 1
        # remove row from state array
        @state.slice!(@buffer_height + row) 
        # add blank row to the top of the state array
        @state.unshift Array.new(@width) { 0 }
        # don't decrement row as the line above has now dropped down
      else
        row -= 1 # process next row
      end
    end
    
    completed_lines_count
  end
  
end