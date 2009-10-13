require File.dirname(__FILE__) + '/common'

form = Form.new
form.text = "Hello world!"

container = FlowLayoutPanel.new
container.dock = DockStyle.fill

form.controls.add(container)

button = Button.new
button.text = "Click!"

button.click do |sender,args|
  MessageBox.Show("Oh, I'm clicked...")
end

container.controls.add button

Application.Run(form)

