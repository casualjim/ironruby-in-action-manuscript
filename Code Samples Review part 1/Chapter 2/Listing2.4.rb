$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'Listing2.1'
require 'Listing2.5'

class AlbumListTest < Test::Unit::TestCase
		
	def setup
		@album1 = Album.new("Ruby Greatest Hits", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
		@album2 = Album.new("Ruby Worst Moments", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
		@album3 = Album.new("Ruby Top 100", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
		
		assert_not_nil @album1.name
				
		@list = AlbumList.new
		@list.append(@album1).append(@album2).append(@album3)
	end
	
	def test_should_append_new_item
		
		assert_not_nil @list, "the list shouldn't be nil at this point"
		assert_equal(3,@list.count, "The list should contain 3 items at this point")
		assert_equal("Ruby Greatest Hits", @list[0].name, "The titles should be equal");
		
	end
	
	def test_should_find_an_item_by_name
		result = @list.find_by_name("Ruby Greatest Hits")
		
		assert_not_nil result, "We should have an album with title Ruby Greatest Hits"
		assert_instance_of(Album, result, "This should be an album object")
	end
	
	def test_should_remove_an_item_with_a_given_name
		@list.remove @album2
		
		assert_not_nil @list, "We should still have a list at this point"
		assert_equal 2, @list.count, "The list should contain 2 items at this point"
		assert_equal @album3.name, @list[1].name, "The album names should be equal" 
				
	end
	
end