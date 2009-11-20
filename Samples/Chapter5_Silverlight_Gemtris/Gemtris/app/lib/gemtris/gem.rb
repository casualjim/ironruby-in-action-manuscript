class Gemtris::Gem
  
  def color=(color=Colors.Red)
    # Get the Path that makes up the background of the gem, and memoize it
    @gem_background ||= find_name('GemBackground')
    @gem_background.fill = SolidColorBrush.new color
  end
  
  def glimmer 
    @glimmer_anim ||= find_name("Glimmer")
    @glimmer_anim.begin
  end
  
  def show
    self.visibility = Visibility.visible
  end
  
  def hide
    self.visibility = Visibility.collapsed
  end
  
end