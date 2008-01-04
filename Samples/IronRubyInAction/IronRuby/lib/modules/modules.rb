class Song
	
	require 'song_ops'
	
	include SongOps
	
	attr_accessor :name

	def initialize(name = 'Ruby Tuesday')
		@name = name
	end

end

song = Song.new
SongOps.capitalize(song.name)

song.play

# Ouputs the following:
# Ruby tuesday
# Playing: Ruby Tuesday