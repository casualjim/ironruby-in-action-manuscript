require 'listing1.15.rb'
require 'listing1.16.rb'

printables = [HelloWorld.new, Book.new("IronRuby In Action")]

printables.each do |printable|
	puts printable.print
end

hw = printables[0]
puts "hw does #{'not ' unless hw.is_a? Printable}implement Printable"