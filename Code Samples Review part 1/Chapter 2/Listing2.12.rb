state = "hungry" 

if state == "hungry" 
	puts "You are hungry, maybe I can help." 
else
	puts "No needs at the moment, maybe later?"
end

def snack?(state)
	puts "What would you like to eat (apple, sandwich, salad)?" if state == "hungry"        
	
	food = gets.chomp
	was_unknown = false
	
	if food == "apple" 
		puts "There are apples in the fruit basket in the lounge." 
	elsif food == "sandwich"
		puts "You can raid the fridge for your sandwich. There is bread in the pantry." 
	elsif food == "salad"
		puts "There are plenty of ingredients for a salad in the fridge." 
	else
		was_unknown = true
		puts "I'm sorry but I don't understand your request."
	end
	
	was_unknown
end

if snack?(state) : puts "Do you want to try again?"; else puts "Do you want more food?";  end; 

want_more = gets.chomp

snack?(state) unless want_more == "no" 						      	     

puts "Thank you for using my services."


# One path could output the following:
#
# You are hungry, maybe I can help.
# What would you like to eat (apple, sandwich, salad)?
# ap
# I'm sorry but I don't understand your request
# Do you want to try again?
# yes
# What would you like to eat (apple, sandwich, salad)?
# sandwich
# You can raid the fridge for your sandwich. There is bread in the pantry.
# thank you for using my services
