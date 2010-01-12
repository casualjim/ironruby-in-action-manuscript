require "Chapter12/bin/Debug/Chapter12.dll"

choc = Chapter12::TheLandOfChocolate::OompaLoompa.make_chocolate :milk, :peppermint

p choc.methods.sort.join(", ")
choc.eat!