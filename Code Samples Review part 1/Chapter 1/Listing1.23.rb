require 'listing1.19.rb'
require 'listing1.20.rb'

printables = [HelloWorld.new, Book.new("IronRuby In Action")]

printables.each do |printable|
	#when you don't really care about what's going to happen next. 
	#If there is a print method it will execute otherwise it will fail
	puts printable.print
end