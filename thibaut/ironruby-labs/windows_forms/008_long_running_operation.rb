$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'magic'

# simple multithreading with windows forms 2:
# - http://www.mikedub.net/mikeDubSamples/SafeReallySimpleMultithreadingInWindowsForms20/SafeReallySimpleMultithreadingInWindowsForms20.htm

# use the background worker stuff to handle long running operations - no sugar yet (except Magic)
form = Magic.build do
  form(:text => "Long running operation") do
    table_layout_panel(:dock => DockStyle.fill) do
      @worker = background_worker(:worker_reports_progress => true, :worker_supports_cancellation => false)

      @worker.do_work do |sender,e|
        # ui stuff forbidden here
        max_loop = e.argument
        max_loop.times do |current_loop|
          sleep(1)
          percent = 100*(1+current_loop)/max_loop
          @worker.report_progress(percent)
        end
      end
      
      @worker.run_worker_completed do
        # ui stuff allowed
        @label.text = "Done!"
        @button.enabled = true
      end
      
      @worker.progress_changed do |s,e|
        # ui stuff allowed here
        @progress_bar.value = e.progress_percentage
      end

      @label = label(:text => "Hello")

      @button = button(:text => "Run")
      @button.click do
        @button.enabled = false # only one processing per background_worker at a time
        # note - on Mac OS X + Mono, the button will look disabled but will actually be enabled
        # see https://bugzilla.novell.com/show_bug.cgi?id=438281
        @label.text = "Please wait..."
        @worker.run_worker_async(10) # run 10 times
      end
      
      @progress_bar = progress_bar
    end
  end
end

Application.Run(form)