require 'song_ops'

class Song
	
	include SongOps
	
	attr_accessor :name

	def initialize(name = 'Ruby Tuesday')
		@name = name
	end

end

song = Song.new
SongOps.capitalize(song.name)


# Ouputs the following:
# Ruby tuesday
