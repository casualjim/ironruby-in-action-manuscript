include System::Windows::Threading

class Gemtris::GameManager
  
  attr_accessor :board, :speed, :timer
  
  def initialize(grid, speed = 500)
    @board = Gemtris::Board.new :grid => grid, :rows => 16, :columns => 10    
    @speed = speed
    
    @timer = DispatcherTimer.new
    timer.interval = System::TimeSpan.from_milliseconds speed
    
    # The game loop
    timer.tick do |sender, args|
      update
      draw
    end
  end
  
  def start
    timer.start
  end
  
  def stop
    timer.stop
  end
  
  def game_over
    stop
    raise "Game over"
  end
  
  def handle_key_press(key)
    case key
    when :up
      board.current_shape.rotate
    else
      board.current_shape.move key
    end
    draw
  end
  
  protected
  
  def update
    # If the shape won't move down then it's collided
    has_collided = board.current_shape.move(:down)
    if has_collided
      if board.current_shape.y <= 0
        game_over
      end
      board.current_shape.place_on_board
      #board.remove_completed_rows
      board.add_new_shape
    end
  end
  
  def draw
    board.draw
  end

end