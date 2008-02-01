class Book
	include Printable
	
	def initialize(message)
		@message = message
	end
	
	def print
		"Book: #{@message}"
	end
end