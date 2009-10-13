require "silverlight"

class App < SilverlightApplication
  # notice: no xaml here
  
  def initialize
    application.root_visual = StackPanel.new

    10.times do |i|
      text_block = TextBlock.new
      text_block.text = i.to_s
      text_block.width = 30
      text_block.height = 30
      root.children.add(text_block)
    end
  end
end

$app = App.new
