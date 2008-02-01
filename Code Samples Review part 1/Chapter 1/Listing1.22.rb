printables.each do |printable|	
	#the wrong way to do it is to use ruby as a statically typed language
	fail TypeError.new("#{printable.class} doesn't implement Printable") unless printable.is_a? Printable
	puts printable.print 
end