class Album
	
	def initialize(name, artist, songs)
		@name = name
		@artist = artist
		@songs = songs
	end
	
	def print
		"Type: #{self.class}\nName: #@name\nArtist: #@artist\nSongs: #{@songs.join(', ')}"
	end
	
end

class Single < Album
	
	def initialize(name, artist, songs)
		super(name, artist, songs)
		@max_song_count = 2
		#make sure there can only be 2 songs on this single
		@songs = songs[0...@max_song_count]
	end
	
end

class Dvd < Album
	
	def initialize(name, artist, songs, movies)
		super(name, artist, songs)
		@movie_clips = movies #set the movie_clips variable
	end
	
	def print
		# append the movie_clips to the output of print
		super << "\nMovie clips: #{@movie_clips.join(', ')}"
	end
	
end

# a cd is a more specific type of album but not different in any way
class Cd < Album; end
	
cd = Cd.new("Ruby Greatest Hits", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
single = Single.new("Ruby Greatest Hits", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"])
dvd = Dvd.new("Ruby Greatest Hits", "Various", ["Summer of 95", "Every character you type", "RubyEyed Girl"], ["First class citizen", "Ruby rush", "Lethal Ruby"])

puts "Album:\n#{cd.print}\n\n"
puts "Album:\n#{single.print}\n\n"
puts "Album:\n#{dvd.print}\n\n"

# outputs the following:
#
# Album:
# Type: Cd
# Name: Ruby Greatest Hits
# Artist: Various
# Songs: Summer of 95, Every character you type, RubyEyed Girl
#
# Album:
# Type: Single
# Name: Ruby Greatest Hits
# Artist: Various
# Songs: Summer of 95, Every character you type
#
# Album:
# Type: Dvd
# Name: Ruby Greatest Hits
# Artist: Various
# Songs: Summer of 95, Every character you type, RubyEyed Girl
# Movie clips: First class citizen, Ruby rush, Lethal Ruby
