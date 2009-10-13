require File.dirname(__FILE__) + '/wpf'

my_window = Window.new
my_window.width = 600
my_window.height = 480
my_window.title = 'Hello world!'

my_stack = StackPanel.new
my_stack.margin = Thickness.new 30
my_window.content = my_stack

my_button = Button.new
my_button.content = 'Click me!'
my_button.font_size = 22
my_button.click {
  MessageBox.show("Ok!")
}

my_stack.children.add my_button

my_app = Application.new
my_app.run(my_window)