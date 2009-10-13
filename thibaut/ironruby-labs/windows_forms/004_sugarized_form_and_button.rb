$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'control'

form = Form.build(:text => "Hello!")
container = FlowLayoutPanel.build(:dock => DockStyle.fill)
container << Button.build(:text => "Click me!", :click => lambda { MessageBox.Show("Hello") })
container << Button.build(:text => "Quit", :click => lambda { Application.Exit })
form << container

Application.Run(form)
