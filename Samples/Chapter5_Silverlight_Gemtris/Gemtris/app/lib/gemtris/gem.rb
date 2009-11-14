class Gemtris::Gem
  
  def initialize
    self.find_name('GemBackground').fill = SolidColorBrush.new(Colors.Green)
  end
  
  def begin_init
    self.find_name('GemBackground').fill = SolidColorBrush.new(Colors.Blue)
  end
  
  def color=(color=Colors.Red)
    @gem_background = self.find_name('GemBackground') if @gem_background == nil
    @gem_background.fill = SolidColorBrush.new(color)
  end
  
  def GemClicked(sender, event)
    color = Colors.Red
  end

end
