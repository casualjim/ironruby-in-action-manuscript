# a first attempt at dsl-ing windows forms menu creation from IronRuby
# some inspiration from http://blog.jayfields.com/2006/07/ruby-block-scope.html

# TODOs:
# - avoid modifying the MainMenu class itself ?
# - code could be simpler
# - allow to create ContextMenu with the same code

class MainMenu
  class << self
    def build(&script)
      instance = self.new
      instance.instance_eval(&script)
      instance
    end
  end

  # add a new menu item.
  # to receive click event:
  # - pass an optional lambda { }
  # - or chain a .click { } call after item()
  def item(label,click_handler=nil)
    @parents ||= [self]
    @parents.push(@parents.last.menu_items.add(label))
    @parents.last.click { click_handler.call } if click_handler
    yield if block_given?
    @parents.pop
  end  
end
