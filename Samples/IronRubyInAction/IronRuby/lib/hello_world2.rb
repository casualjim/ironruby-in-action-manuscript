module Printable
	def print
		@message
	end
end

class HelloWorld
	
	include Printable
	
	def initialize
		@message = "Hello world !!!"
	end
	
end

class Book
	include Printable
	
	def initialize(message)
		@message = message
	end
end

printables = [HelloWorld.new, Book.new("IronPython In Action")]

printables.each do |printable|
	#if you absolutely need to be sure it will behave correctly
	fail TypeError.new("We expect the method print to be on the object <<printable>>") unless printable.respond_to?(:print)	
	puts printable.print
end

printables.each do |printable|
	#when you don't really care about what's going to happen next
	puts printable.print
end


printables.each do |printable|	
	#the wrong way to do it is to use ruby as a statically typed language
	fail TypeError.new("#{printable.class} doesn't implement Printable") unless printable.is_a? Printable
	puts printable.print 
end




hw = printables[0]

puts "hw does #{'not ' unless hw.is_a? Printable}implement Printable"
