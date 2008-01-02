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

require 'album_list' 
class AlbumList
	
	def each_in_range(range, &block)
		@internal_list[range].each do |album|
			yield album
		end
	end
end

list = AlbumList.new

list.append("Ruby tuesday").append("Ruby is a diamond").append("Ruby rocks")

puts "\nCustom iterator:"
list.each_in_range(0..1){|album| puts album}

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
# 
# Custom iterator:
# Ruby tuesday
# Ruby is a diamond
