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
  
  protected
  
  def update
    # If the shape won't move down then it's collided
    has_collided = board.current_shape.move(:down)
    if has_collided
      if board.current_shape.y <= 0
        game_over
      end
      
      board.current_shape.place_on_board
      board.remove_completed_rows
      board.add_new_shape
    end
  end
  
  def draw
    board.draw
  end
  
  def key_handler(sender, args)
    #raise args.key.GetType.to_s
    case args.key
    when System::Windows::Input::Key.left
      board.current_shape.move :left
    when System::Windows::Input::Key.right
      board.current_shape.move :right
    when System::Windows::Input::Key.down
      board.current_shape.move :down
    when System::Windows::Input::Key.up
      board.current_shape.rotate_counter_clockwise
    end
    draw
  end

end