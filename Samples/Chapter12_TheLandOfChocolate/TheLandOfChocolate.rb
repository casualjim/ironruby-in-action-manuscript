require "Chapter12/bin/Debug/Chapter12.dll"
load_assembly 'Chapter12.TheLandOfChocolate', 'Chapter12.TheLandOfChocolate'

choc = Chapter12::TheLandOfChocolate::OompaLoompa.make_chocolate :milk, :peppermint

p choc.methods.sort.join(", ")
choc.eat!