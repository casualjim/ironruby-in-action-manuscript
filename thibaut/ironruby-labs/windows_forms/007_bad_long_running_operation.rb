$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'magic'

# an example of what you should *not* do with long-running operations (ie. process them in UI thread)

form = Magic.build do
  form(:text => "Long running operation") do
    flow_layout_panel(:dock => DockStyle.fill) do
      @label = label(:text => "Hello")

      button(:text => "Freeze UI").click do
        @label.text = "Please wait..."
        sleep(5) # long runnin operation in the thread of the UI - will freeze the events loop
        @label.text = "Done - with pain"
      end
    end
  end
end

Application.Run(form)