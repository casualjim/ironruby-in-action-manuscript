class Gemtris::Gem
  
  def color=(color=Colors.Red)
    # Get the Path that makes up the background of the gem
    @gem_background = self.find_name('GemBackground') if @gem_background == nil
    @gem_background.fill = SolidColorBrush.new(color)
  end
  
  def show
    self.visibility = Visibility.visible
  end
  
  def hide
    self.visibility = Visibility.collapsed
  end
  
end