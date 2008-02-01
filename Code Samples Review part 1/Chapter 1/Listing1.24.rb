printables.each do |printable|
	#if you absolutely need to be sure it will behave correctly
	fail TypeError.new("We expect the method print to be on the object <<printable>>") unless printable.respond_to?(:print)	
	puts printable.print
end
