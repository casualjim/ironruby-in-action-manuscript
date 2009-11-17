include System::Windows::Threading

class Gemtris::GameManager
  
  attr_reader :state, :timer, :board, :next_shape_board, :sounds, :completed_lines_count
  attr_accessor :next_shape_key, :speed, :speed_up
  
  def initialize(grid, next_shape_grid, row_count_textblock, options = {})
    options = {
      :speed => 500,
      :speed_up => 5
    }.merge(options)
    
    @board = Gemtris::Board.new :grid => grid, :height => 16, :width => 10, :buffer_height => 4
    @next_shape_board = Gemtris::Display.new :grid => next_shape_grid, :height => 4, :width => 4
    @row_count_textblock = row_count_textblock
    @speed = System::TimeSpan.from_milliseconds options[:speed]
    @speed_up = options[:speed_up]
    
    @completed_lines_count = 0
    
    update_next_shape
    
    # The game loop timer
    
    # METHOD 1
    # @timer = DispatcherTimer.new
    # timer.interval = System::TimeSpan.from_milliseconds(speed)
    # timer.tick do |sender, e|
    #   update
    #   draw
    # end
    
    # METHOD 2: Better!
    @game_loop = System::Windows::Media::Animation::Storyboard.new
    @game_loop.duration = @speed
    @game_loop.completed do |sender, e|
      update
      draw
      @game_loop.begin # loop
    end
    
    @state = :stopped
  end
  
  def start
    #timer.start
    @game_loop.begin
    @state = :playing
  end
  
  def stop
    #timer.stop
    @game_loop.stop
    @state = :stopped
  end
  
  def game_over
    stop
    @state = :game_over
    @completed_lines_count = 0
    raise "Game over"
  end
  
  def handle_key_press(key)
    return unless @state == :playing
    
    case key
    when :up
      board.current_shape.rotate
    when :space
      board.current_shape.drop
    else
      board.current_shape.move key
    end
    board.draw
  end
  
  protected
  
  def update_next_shape
    @next_shape_key = Gemtris::Shape.random_key
    
    next_shape = Gemtris::Shape.new(@next_shape_board, @next_shape_key)
    next_shape.x = 0
    next_shape.y = 1
    if next_shape.height > next_shape.width
      next_shape.rotate
    end
    
    next_shape_board.set_current_shape next_shape
    next_shape.glimmer
  end
  
  def update
    return unless @state == :playing
    
    # If the shape won't move down then it's collided
    has_collided = board.current_shape.move(:down)
    if has_collided
      if board.current_shape.in_shape_buffer?
        game_over and return
      end
      
      board.current_shape.place_on_board
      
      num_of_lines_removed = board.remove_completed_rows
      if num_of_lines_removed > 0
        @completed_lines_count += num_of_lines_removed
        @game_loop.duration = @game_loop.duration.subtract System::TimeSpan.from_milliseconds(num_of_lines_removed * @speed_up) #speed the game up
        @row_count_textblock.text = "Lines: #{@completed_lines_count}"
      end
      
      board.set_current_shape Gemtris::Shape.new(board, next_shape_key)
      update_next_shape
    end
  end
  
  def draw
    board.draw
    next_shape_board.draw
  end

end