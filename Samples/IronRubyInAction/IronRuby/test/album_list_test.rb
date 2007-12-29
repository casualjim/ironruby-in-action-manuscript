$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'album_list'
require 'album'

class AlbumListTest < Test::Unit::TestCase
		
	def test_should_append_new_item
		album1 = Album.new("Ruby Greatest Hits", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
		album2 = Album.new("Ruby Top 100", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
		album3 = Album.new("Ruby Worst Moments", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
		
		list = AlbumList.new
		list.append(album1).append(album2).append(album3)
		
		assert_not_nil list, "the list shouldn't be nil at this point"
		assert_equal(3,list.count, "The list should contain 3 items at this point")
		assert_equal(album1.artist, list[0].artist, "The artists should be equal");
	end
	
end