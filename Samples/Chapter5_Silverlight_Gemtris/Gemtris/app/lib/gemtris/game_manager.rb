include System::Windows::Threading # Provides DispatchTimer class
include Gemtris

class Gemtris::GameManager
  
  attr_reader :state, :timer, :board, :next_shape_board, :sounds, :completed_lines_count
  attr_accessor :next_shape_key, :speed, :speed_up
  
  def initialize(grid, next_shape_grid, row_count_textblock, options = {})
    options = {
      :speed => 500,
      :speed_up => 5
    }.merge(options)
    
    @board = Board.new grid, :height => 16, :width => 10, :buffer_height => 4
    @next_shape_board = Display.new next_shape_grid, :height => 2, :width => 4
    @row_count_textblock = row_count_textblock
    @speed = System::TimeSpan.from_milliseconds options[:speed]
    @speed_up = options[:speed_up]
    @sounds = options[:sounds]
    @state = :stopped
    @completed_lines_count = 0
    update_next_shape
    
    # The game loop timer
    
    # METHOD 1 - DispatcherTimer
    @timer = DispatcherTimer.new
    timer.interval = @speed
    timer.tick do |sender, e|
      update
      draw
    end
    
    # METHOD 2 - Storyboard Trigger
    # @game_loop = System::Windows::Media::Animation::Storyboard.new
    # @game_loop.duration = @speed
    # @game_loop.completed do |sender, e|
    #   update
    #   draw
    #   @game_loop.begin # loop
    # end
    
    # Listen to key presses on the root control
    Application.current.root_visual.key_down { |sender, args| handle_key_press args.key.to_s.downcase.to_sym }
  end
  
  def start
    timer.start
    # @game_loop.begin
    @state = :playing
  end
  
  def stop
    timer.stop
    # @game_loop.stop
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
  
  def play_sound key
    snd = @sounds[key]
    if snd
      snd.stop # reset the sound
      snd.play
    end
  end
  
  def update_next_shape
    @next_shape_key = Shape.random_key

    next_shape = Shape.new(@next_shape_board, @next_shape_key)
    next_shape.y = 0
  
    # Keep tall shapes rotated to be horizontal
    if next_shape.height > next_shape.width
      next_shape.rotate
    end

    next_shape_board.set_current_shape next_shape
    next_shape.glimmer
  end

  def update
    return unless @state == :playing
  
    # If the shape won't move down then it's collided
    if not board.current_shape.move(:down)
      play_sound :gem_placed
      board.current_shape.place_on_board

      if board.current_shape.in_shape_buffer?
        play_sound :game_over
        game_over and return
      end
    
      num_of_lines_removed = board.remove_completed_rows
      if num_of_lines_removed > 0
        play_sound :line_completed
        @completed_lines_count += num_of_lines_removed
      
        #speed the game up when using Storyboard Trigger
        #@game_loop.duration = @game_loop.duration.subtract System::TimeSpan.from_milliseconds(num_of_lines_removed * @speed_up) 
      
        #speed the game up when using DispatchTimer
        @timer.interval = @timer.interval.subtract System::TimeSpan.from_milliseconds(num_of_lines_removed * @speed_up) 
      
        @row_count_textblock.text = "Lines: #{@completed_lines_count}"
      end
    
      board.set_current_shape Shape.new(board, next_shape_key)
      update_next_shape
    end
  end

  def draw
    board.draw
    next_shape_board.draw
  end

end