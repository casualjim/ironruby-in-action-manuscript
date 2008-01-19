class DependencyObject
  def name=(value)
    WpfHelpers.set_dependency_object_name(self, value.to_s)
  end  
end

class TextBlock
  
  include Wpf::Dockable
  
  alias_method :old_font_family=, :font_family=
  def font_family=(value)
    self.old_font_family = FontFamily.new(value)
  end
  
  alias_method :old_background=, :background=  
  def background=(color)
    self.old_background = case color
    when :black
      Brushes.black
    when :white
      Brushes.white
    when :green
      Brushes.green
    when :alice_blue
      Brushes.alice_blue
    end
  end    
end

class TextBox
  include Wpf::Dockable
end

class Frame
  include Wpf::Dockable
  
  
  alias_method :old_source=, :source=
  def source=(uri)
    self.old_source = Uri.new uri
  end
  
end

class ListBox
  include Wpf::Dockable
  
  alias_method :old_background=, :background=  
  def background=(color)
    self.old_background = case color
    when :black
      Brushes.black
    when :gray
      Brushes.gray
    when :white
      Brushes.white
    when :green
      Brushes.green
    when :alice_blue
      Brushes.alice_blue
    end
  end    
end

class Panel
  include Wpf::Builders
  include Wpf::ChildrenBuilder
  include Wpf::Dockable

  alias_method :old_background=, :background=   
  
  def background=(color)
    self.old_background = case color
    when :black
      Brushes.black
    when :white
      Brushes.white
    when :green
      Brushes.green
    when :alice_blue
      Brushes.alice_blue
    end
  end 
end

class StackPanel
  
  alias_method :old_orientation= , :orientation=
  
  def orientation=(orient)
    
    self.old_orientation= case orient
    when :horizontal
      Orientation.horizontal
    when :vertical
      Orientation.vertical
    end
  end
end

class Window
  include Wpf::Builders
	
  def add(klass, args = {}, &b)
    assign_to_name_collector :content=, klass, args, &b
  end
  
  def method_missing(m, *args)
    match = /^bind_(.+)$/.match(m.to_s) 
    if match
      self.send :create_binding, m.to_s
    end
  end
  
  def create_binding(m)
    puts "creating binding: #{m} "
  end
  
end


