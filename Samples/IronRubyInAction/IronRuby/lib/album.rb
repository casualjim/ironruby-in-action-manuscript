class Album
	attr_reader :name, :artist, :songs
	
	def initialize(name, artist, songs)
		@name = name
		@artist = artist
		@songs = songs
	end
	
	def print
		"Name: #@name\nArtist: #@artist\nSongs: #{@songs.join(', ')}"
	end
	
end

#album = Album.new("Ruby Greatest Hits", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
#
#puts "Album: "
#puts album.print

# outputs the following:
#
# Album:
# Name: Ruby Greatest Hits
# Artist: Various
# Songs: Summer of 95, Every character you type, RubyEyed Girl
