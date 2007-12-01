require 'hello_world'

hw = HelloWorld.new
puts hw.print

def output(to_output)
	fail TypeError.new("We expect the method print to be on the object <<to_output>>") unless to_output.respond_to?(:print)
	
	puts to_output.print	
end

output(hw)
