# A Gemtris shape is a collection of Gemtris gem blocks
#
class Gemtris::Shape
  
  SHAPES = {
    :I => {
      :colour => Colors.Red,
      :data => [
        [0,1,0],
        [0,1,0],
        [0,1,0],
        [0,1,0],
      ]
    },
    :J => {
      :colour => Colors.Orange,
      :data => [
        [1,1,1],
        [0,0,1],
        [0,0,0],
      ],
    },
    :L => {
      :colour => Colors.Purple,
      :data => [
        [1,1,1],
        [1,0,0],
        [0,0,0],
      ],
    },
    :O => {
      :colour => Colors.Blue,
      :data => [
        [1,1],
        [1,1],
      ],
    },
    :S => {
      :colour => Colors.Green,
      :data => [
        [0,1,1],
        [1,1,0],
      ],
    },
    :T => {
      :colour => Colors.Silver,
      :data => [
        [1,1,1],
        [0,1,0],
        [0,1,0],
      ],
    },
    :Z => {
      :colour => Colors.Cyan,
      :data => [
        [1,1,0],
        [0,1,1],
      ]
    }
  }
  
  attr_accessor :colour, :x, :y
  
  def initialize(shape = self.random, x=0, y=0)
    @x, @y = x, y
    @colour = shape.colour
    @orientations = generate_orientations(shape.data)
  end
  
  # Pick a random game element shape
  #
  def self.random
    SHAPE[ SHAPE.keys[ rand SHAPE.length ] ]
  end
  
  def rotate_clockwise
    
  end
  
  def rotate_counter_clockwise
    
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
