include System::Windows::Threading

class Gemtris::GameManager
  
  attr_accessor :board, :speed, :timer
  
  def initialize(grid, speed = 500)
    @board = Gemtris::Board.new :grid => grid, :rows => 16, :columns => 10    
    @speed = speed
    
    # The game loop timer
    @timer = DispatcherTimer.new
    timer.interval = System::TimeSpan.from_milliseconds speed    
    timer.tick do |sender, args|
      update
      draw
    end
    
    @state = :stopped
  end
  
  def start
    timer.start
    @state = :playing
  end
  
  def stop
    timer.stop
    @state = :stopped
  end
  
  def game_over
    stop
    @state = :game_over
    raise "Game over"
  end
  
  def handle_key_press(key)
    return unless @state == :playing
    
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
    return unless @state == :playing
    
    # If the shape won't move down then it's collided
    has_collided = board.current_shape.move(:down)
    if has_collided
      if board.current_shape.y <= 0
        game_over and return
      end
      board.current_shape.place_on_board
      board.remove_completed_rows
      board.add_new_shape
    end
  end
  
  def draw
    board.draw
  end

end