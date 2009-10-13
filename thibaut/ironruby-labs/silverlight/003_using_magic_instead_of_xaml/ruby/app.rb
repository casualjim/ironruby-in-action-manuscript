require "silverlight"
require "magic-compressed"

class App < SilverlightApplication
  
  def initialize
    application.root_visual = Magic.build do
      stack_panel do
        10.times { |i| text_block(:text => i.to_s, :width => 30,:height => 30) }
      end
    end
  end
end

$app = App.new
