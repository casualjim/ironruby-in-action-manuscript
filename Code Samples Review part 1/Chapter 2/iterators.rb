collection = %w(Some words in a collection)

#for iterator
puts "With a for iterator:"
for word in collection
	puts word
end

#with a block
puts "\nWith a block iterator:"
collection.each do |word|
	print "#{word} "
end
print "\n"

# Produces the following output:
#
# With a for iterator:
# Some
# words
# in
# a
# collection
# 
# With a block iterator:
# Some words in a collection