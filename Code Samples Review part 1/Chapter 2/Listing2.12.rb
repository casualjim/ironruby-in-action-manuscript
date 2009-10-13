require 'Listing2.5' 

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
# Custom iterator:
# Ruby tuesday
# Ruby is a diamond
