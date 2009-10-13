@foods = %w(apple salad sandwich burger quesadilla)

def get_random_food
	@foods[rand(@foods.length)]
end

def propose_food
	puts "Today, we recommend you try:"
	
	#will pass 2 random foods to the block
	yield get_random_food, get_random_food if block_given?
	
	puts "Do any of those appeal to you?"
end

def propose_variable_amount_of_foods(&block)
	puts "Today, we recommend you try"
	case block.arity
	when -1 #no parameters were given
		yield
	when 1
		yield get_random_food
	when 2
		yield get_random_food, get_random_food
	when 3
		yield get_random_food, get_random_food, get_random_food
	end
	puts 'Do any of those appeal to you?'
end

propose_food do |food1, food2|
	puts "A delicious #{food1.upcase} or a divine #{food2.upcase}"
end
puts "\nVariable number of parameters"

# A block is expected by the method now.
propose_variable_amount_of_foods { puts "No specials today" }

propose_variable_amount_of_foods do |food1, food2, food3| 
	puts "A delicious #{food1.upcase}, a #{food2.upcase} to die for or a divine #{food3.upcase}"
end

# A possible output:
#
# Today, we recommend you try:
# A delicious QUESADILLA or a divine SANDWICH
# Do any of those appeal to you?
# 
# Variable number of parameters
# Today, we recommend you try
# No specials today
# Do any of those appeal to you?
# Today, we recommend you try
# A delicious BURGER, a APPLE to die for or a divine SALAD
# Do any of those appeal to you?