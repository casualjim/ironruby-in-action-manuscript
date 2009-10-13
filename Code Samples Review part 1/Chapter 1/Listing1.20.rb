require 'listing1.19.rb'
require 'listing1.20.rb'

printables = [HelloWorld.new, Book.new("IronRuby In Action")]

printables.each do |printable|
	#if you absolutely need to be sure it will behave correctly
	fail TypeError.new("We expect the method print to be on the object <<printable>>") unless printable.respond_to?(:print)	
	puts printable.print
end
