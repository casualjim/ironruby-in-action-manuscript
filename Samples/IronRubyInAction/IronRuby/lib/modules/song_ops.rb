module SongOps

	def SongOps.capitalize(string = 'some string')
		puts string.upcase
	end

	def play
		 puts "Playing: #@name"
	end
end