class Gemtris::Gem
  
  def initialize
    color=Colors.green
    
    self.mouse_left_button_down do |sender, e|
      color=Colors.blue
    end
  end
  
  def color=(color=Colors.Red)
    # Get the Path that makes up the background of the gem
    @gem_background = self.find_name('GemBackground') if @gem_background == nil
    @gem_background.fill = SolidColorBrush.new(color)
  end
  
end