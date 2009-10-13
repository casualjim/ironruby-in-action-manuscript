$LOAD_PATH << File.dirname(__FILE__)
require 'common'
require 'magic'

# long running operation with modal progress
# nb: a cancellable version is absolutely possible

form = Magic.build do
  form(:text => "Long running operation", :width => 400) do
      button(:text => "Click me for something that should last a bit", :width => 400).click do

        # create the modal form - control_box => false disable the close button
        
        @modal_form = form(:text => "Modal!", :control_box => false) do
          @progress_bar = progress_bar
        end

        # create the worker thread, without starting it
        
        @worker = background_worker(:worker_reports_progress => true)

        @worker.do_work do |sender,e|
          max_loop = 20
          # ui stuff forbidden here
          max_loop.times do |current_loop|
            sleep(1)
            percent = 100*(1+current_loop)/max_loop
            @worker.report_progress(percent)
          end
        end

        @worker.run_worker_completed do
          # ui stuff allowed here
          @modal_form.close
        end

        @worker.progress_changed do |s,e|
          # ui stuff allowed here
          @progress_bar.value = e.progress_percentage
        end

        # register the thread so that it is started automatically once the form is shown
        
        @modal_form.load do
          @worker.run_worker_async
        end

        # and ask to show the form in a modal fashion
        
        @modal_form.show_dialog
    end
  end
end

Application.Run(form)