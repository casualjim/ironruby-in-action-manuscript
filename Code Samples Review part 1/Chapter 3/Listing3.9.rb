p "loading components, please wait..."

require 'wpf'
require 'wpf_elements'

class WpfApplication < Application
  
  def initialize()
    run yield 
  end
    
end

start_url = "http://www.ironruby.net"
title = "Biffy"

WpfApplication.new do 
  
  # build the window
  obj = Wpf.build Window, :title => title, :height => 500, :width => 826, :name => "Biffy"  do
    add DockPanel, :name => "dock_panel" do
      add TextBlock, :text => title, :font_size => 36, :background => :alice_blue, :dock => :top, :name => "text_block"

      add StackPanel, :orientation => :horizontal, :dock => :top, :name => "stack_panel" do
        add TextBox, :text => start_url, :width => 750, :name => "web_url"
        add Button, :content => "Show site", :name => "get_url_button"
      end

      add Frame, :source => start_url, :name => 'web_page_display'

    end
  end

  # attach the event handler
  obj['get_url_button'].click do 
    obj["web_page_display"].source = obj["web_url"].text
  end
  
  obj
end

