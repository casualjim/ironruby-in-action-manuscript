$LOAD_PATH << File.dirname(__FILE__)
$LOAD_PATH << File.dirname(__FILE__) + '/magic/lib'

require 'wpf'
require 'magic'

my_window = Magic.build do
  window(:width => 600, :height => 480, :title => 'Hello world!') do
    stack_panel(:margin => thickness(30)) do
      button(:content => 'Click me!', :font_size => 22).click do
        MessageBox.show("Ok!")
      end
    end
  end
end

my_app = Application.new
my_app.run(my_window)