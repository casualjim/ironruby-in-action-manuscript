p "loading components, please wait..."

# get the necessary assemblies loaded for .NET
require 'mscorlib'
require 'System, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089' 
require 'System.Xml, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
require 'PresentationFramework, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'
require 'PresentationCore, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35'

# include some namespaces for easy access
include System
include System::Windows
include System::Windows::Controls
include System::Windows::Markup
include System::Windows::Media
include System::Windows::Media::Animation
include System::Xml

my_window = Window.new
my_window.title = 'Biffy'
my_window.height = 500
my_window.width = 826

my_dock = DockPanel.new
my_window.content = my_dock
header = TextBlock.new
header.background = Brushes.AliceBlue
header.font_size = 36
header.text = "Biffy"
DockPanel.set_dock header, Dock.Top

my_dock.children.add header

start_url = "http://www.ironruby.net"

top_stack = StackPanel.new
top_stack.orientation = Orientation.Horizontal

feed_url = TextBox.new
feed_url.text = start_url
feed_url.width = 750
DockPanel.set_dock top_stack, Dock.Top

load_feed_button = Button.new
load_feed_button.content = "Show site"

top_stack.children.add feed_url
top_stack.children.add load_feed_button
my_dock.children.add top_stack

frame = Frame.new
frame.source = Uri.new start_url

my_dock.children.add frame


load_feed_button.click do |event, args|
  frame.source = Uri.new feed_url.text
end

my_app = Application.new
my_app.run my_window


