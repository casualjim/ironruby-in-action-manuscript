class Displayer
	def display(number)
		p "Displaying #{number ? number : 'all'}"
	end
	
	[["one", 1],["ten", 10], ["all", nil]].each do |method_suffix, param|
		define_method("display_#{method_suffix}") do
			display(param)
		end
	end
end

displayer = Displayer.new

displayer.display_one
displayer.display_ten
displayer.display_all

# Generates the following output:
#
# "Displaying 1"
# "Displaying 10"
# "Displaying all"