printables = [HelloWorld.new, Book.new("IronPython In Action")]

printables.each do |printable|
	puts printable.print
end

hw = printables[0]
puts "hw does #{'not ' unless hw.is_a? Printable}implement Printable"