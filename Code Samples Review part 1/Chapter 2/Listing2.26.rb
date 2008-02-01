class MusicLibrary < Array
	
	def add_album(artist, title)
		self << [artist, title]
		self
	end
	
	def search_by_artist(key)
		reject { |b| !match_item(b, 0, key) }
	end
	
	def search_by_artist_or_title(key)
		reject { |b| !match_item(b, 0, key) && !match_item(b, 1, key) }
	end  
	
	private	
	def match_item(b, index, key)
		b[index].index(key) != nil
	end
	
	def method_missing(method, *args)
		method_match = /find_(.+)/.match(method.to_s)
		search_by_artist_or_title(method_match.captures[0]) if method_match
	end
end

l = MusicLibrary.new
l.add_album("Lenny Kravitz", "Mama said").add_album("Kruder & Dorfmeister", "Sofa surfers")
l.add_album("Massive Attack", "Safe from harm").add_album("Paul Oakenfold", "Bunkha")

p "Find Kravitz:"
l.find_Kravitz.each do |item|; p item; end

p "Find Ma:"
l.find_Ma.each do |item|; p item; end

p "Find Bu:"
l.find_Bu.each do |item|; p item; end

# Outputs the following:
#
# "Find Kravitz:"
# ["Lenny Kravitz", "Mama said"]
# "Find Ma:"
# ["Lenny Kravitz", "Mama said"]
# ["Massive Attack", "Safe from harm"]
# "Find Bu:"
# ["Paul Oakenfold", "Bunkha"]