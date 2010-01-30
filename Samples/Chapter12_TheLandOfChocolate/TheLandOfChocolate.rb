require "Chapter12/bin/Debug/Chapter12.dll"
puts Chapter12.constants.join(", ")

load_assembly "Chapter12"

puts Chapter12.constants

puts Chapter12::TheLandOfChocolate::Chocolate.new.methods

#choc = Chapter12::TheLandOfChocolate::OompaLoompa.make_chocolate :milk, :peppermint

#p choc.methods.sort.join(", ")
#choc.eat!