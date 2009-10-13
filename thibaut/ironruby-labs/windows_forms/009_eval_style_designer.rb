$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'magic'

# very flaky, yet working. needs more work

form = Magic.build do
  (@designed_form = form(:text => "Live preview", :top_most => true)).show
  
  form(:text => "Designer", :width => 800, :height => 435) do
      @code = text_box(:multiline => true, :dock => DockStyle.fill)
      @code.text = '
      Magic.build do
        flow_layout_panel(:dock => DockStyle.fill) do
          label(:text => "Hello")
          label(:text => Time.now.to_s)
        end
      end
      '
      
      @code.text_changed do
        begin
          stuff = eval(@code.text.to_s)
          @designed_form.controls.clear
          @designed_form.controls.add stuff
        rescue => e
          #
        end
      end
  end
end

Application.Run(form)