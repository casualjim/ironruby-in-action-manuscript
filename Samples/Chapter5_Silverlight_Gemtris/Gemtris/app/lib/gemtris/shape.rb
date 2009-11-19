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
  
  attr_reader :board
  attr_accessor :x, :y

  def initialize(board, key=random_key)
    # Track the board we belong to
    @board = board

    # Assign our shape data based on the key passed in, or randomly generated
    shape = SHAPES[ key ]
    @key = key
    
    # Rotate the data array
    @orientations = generate_orientations shape[:data]
    @orientation_index = 0
    
    @color = shape[:color]
        
    # Position the shape to start in the shape buffer by giving it a relative negative value
    @y = -height
    # Position the shape in the middle of the board
    @x = (board.width / 2) - (width / 2) - 1
  end
  
  def data
    return @orientations[@orientation_index]
  end
  
  def width
    data[0].length
  end
  
  def height
    data.length
  end
  
  # Pick a random game element shape
  #
  def random_key
    SHAPES.keys[ rand SHAPES.length ]
  end
  
  def self.random_key
    SHAPES.keys[ rand SHAPES.length ]
  end
  
  def rotate
    old_index = @orientation_index
    @orientation_index = (@orientation_index + 1) % 4
    
    # new orientation collides or out of bounds
    if will_collide?
      out_of_bounds_right = (x + width > board.width)
      if out_of_bounds_right
        proposed_x = (board.width - width)
        # proposal is good, move shape to fix on screen
        if will_collide?(proposed_x) == false
          @x = proposed_x
          return
        end
      end
      
      @orientation_index = old_index
    end
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
    
    collided
  end
  
  def drop
    while move(:down) == false
    end
  end
  
  # Does this shape collide at the given x,y coordinates?
  # If not coordinates are passed then the shape's current coordinates are used.
  #
  def will_collide?(x=@x, y=@y)
    height.times do |row|
      width.times do |col|
        if (row+y == board.height) || # reached end of board
           (col+x < 0) || # out of bounds left
           (col+x > board.width) || # out of bounds right
           (data[row][col] != 0 && board.state_at(col+x, row+y) != 0) # collides with a shape next to it
          return true 
        end
      end
    end
    return false
  end
  
  def in_shape_buffer?
    y >= -height && y < 0
  end
  
  def place_on_board(x=@x, y=@y)    
    height.times do |row|
      width.times do |col|
        if data[row][col] != 0
          board.set_state_at(col+x, row+y, @key)
        end
      end
    end
  end

  def draw
    height.times do |row|
      width.times do |col|
        # Only render the gem if it's moved out of the buffer (relative coordinate is not negative)
        if row+@y >= 0
          g = board.gem_at(col+@x, row+@y)
          if data[row][col] != 0
            g.show
            g.color = @color
          end
        end
      end
    end
  end
  
  def glimmer
    height.times do |row|
      width.times do |col|
       if data[row][col] != 0
         board.gem_at(col+x, row+y).glimmer
       end
      end
    end
  end
  
  private
  
  # Pre-compute the possible orientations for a shape array by rotating it 3 times
  #
  def generate_orientations(shape_array)
    # Add the initial shape into the array
    orientations = [ shape_array ]

    # Now rotate the previously rotated array around 90, 180, 270 degrees
    3.times do
      orientations << orientations[-1].dup.rotate
    end
    
    orientations
  end # generate_orientations
  
end
