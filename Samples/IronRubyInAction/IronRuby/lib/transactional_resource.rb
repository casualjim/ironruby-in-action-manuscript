class PickyEater
	attr_reader :food
	
	def initialize(foods)
		@foods = foods
	end	
	
	def food=(new_food)
		@food = new_food
		raise "I don't like #@food."  if @foods.include? new_food
	end
	
	def safe_receive_food
		old_food = @food
		
		begin
			yield self if block_given?
		rescue
			puts "This was one of the unliked foods"
			@food = old_food
		end
	end
end

foods = %w(banana salad sandwich burger quesadilla sushi taco burito)
picky_eater = PickyEater.new foods[0...2]

picky_eater.food= foods[5]
puts "Currently eating: #{picky_eater.food}"
picky_eater.safe_receive_food do|fd| 
	puts "about to serve #{foods[1]}"
	fd.food= foods[1]
end
puts "Currently eating: #{picky_eater.food}"

# Outputs the following:
#
# Currently eating: sushi
# about to serve salad
# This was one of the unliked foods
# Currently eating: sushi
