# A Gemtris shape is a collection of Gemtris gem blocks
#
class Gemtris::Shape
  
  SHAPES = {
    :I => {
      :color => Colors.red,
      :data => [
        [1],
        [1],
        [1],
        [1],
      ]
    },
    :J => {
      :color => Colors.orange,
      :data => [
        [1,1,1],
        [0,0,1],
      ],
    },
    :L => {
      :color => Colors.purple,
      :data => [
        [1,1,1],
        [1,0,0],
      ],
    },
    :O => {
      :color => Colors.blue,
      :data => [
        [1,1],
        [1,1],
      ],
    },
    :S => {
      :color => Colors.green,
      :data => [
        [0,1,1],
        [1,1,0],
      ],
    },
    :T => {
      :color => Colors.gray,
      :data => [
        [1,1,1],
        [0,1,0],
      ],
    },
    :Z => {
      :color => Colors.cyan,
      :data => [
        [1,1,0],
        [0,1,1],
      ]
    }
  }
  
  attr_reader :board, :data, :color, :height, :width
  attr_accessor :x, :y

  def initialize(board, shape_key=random_key)
    # Track the board we belong to
    @board = board

    # Assign our shape data based on the key passed in, or randomly generated
    shape = SHAPES[ shape_key ]
    @shape_key = shape_key
    @color = shape[:color]
    @data = shape[:data]
    @height = data.length
    @width = data[0].length
    
    # Position the shape to start in the shape buffer by giving it a relative negative value
    @y = -@height
    # Position the shape in the middle of the board
    @x = (board.width / 2) - (@width / 2) - 1
    
    #@orientations = generate_orientations shape[:data]
  end
  
  # Pick a random game element shape
  #
  def random_key
    SHAPES.keys[ rand SHAPES.length ]
  end
  
  def rotate_counter_clockwise
    
  end
  
  def move(direction)
    dx = dy = 0
    case direction
      when :right :
        dx = +1
      when :left :
        dx = -1
      when :down :
        dy = +1        
    end
    
    # Ask if this new coordinate would make this shape collide with something on the board
    collided = will_collide?(@x + dx, @y + dy)
    
    # If they don't collide move the shape
    if not collided
      @x += dx
      @y += dy
    end
    
    # Return the collision state for the new position
    collided
  end
  
  # Does this shape collide at the given x,y coordinates?
  # If not coordinates are passed then the shape's current coordinates are used.
  #
  def will_collide?(x=@x, y=@y)
    @height.times do |row|
      @width.times do |col|
        if (row+y == board.height) || # reached end of board
           (col+x < 0) || (col+x > board.width) || # out of bounds
           (data[row][col] != 0 && board.state_at(col+x, row+y) != 0) # collides with a shape next to it
          return true 
        end
      end
    end
    
    false
  end
  
  def place_on_board(x=@x, y=@y)
    @height.times do |row|
      @width.times do |col|
        if data[row][col] != 0
          board.set_state_at(col+x, row+y, @shape_key)
        end
      end
    end
  end
  
  def draw
    @height.times do |row|
      @width.times do |col|
        # Only render the gem if it's moved out of the buffer (relative coordinate is not negative)
        if row+@y >= 0
          g = board.gem_at(col+@x, row+@y)
          if data[row][col] != 0
            g.show
            g.color = color
          end
        end
      end
    end
  end
  
  private
  
  # Pre-compute the possible orientations for a shape array by rotating it 3 times
  #
  def generate_orientations(shape_array)
    # Add the initial shape into the array
    result = [shape_array]

    # Now rotate the previously rotated array around 90, 180, 270 degrees
    3.times do
      result << rotate_array_90deg(result[-1])
    end

    result
  end # generate_orientations

  def rotate_array_90deg(array)
    rows, cols = array.length, array[0].length
    
    # Create the rotated array (cols width x rows high)
    rotated = Array.new(cols) { Array.new(rows) }
    
    # Copy values from the source array into the rotated array
    rows.times do |i|
      cols.times do |j|
        ti = ( rows > cols ? cols-i-1 : 0 )
        tj = ( rows < cols ? rows-j-1 : 0 )

        rotated[j-tj][cols-ti] = array[i][j]
      end
    end
    
    rotated
  end # rotate_90deg
  
end
