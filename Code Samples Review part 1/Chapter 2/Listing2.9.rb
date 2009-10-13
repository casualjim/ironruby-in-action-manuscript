def which_snack?
	puts "What would you like to eat (apple, sandwich, salad)?"        
	
	food = gets.chomp
	was_unknown = false
	
	case food
	when "apple": puts "There are apples in the fruit basket in the lounge." 
	when "sandwich"
		puts "You can raid the fridge. There is bread in the pantry." 
	when "salad" then puts "There are plenty of ingredients for a salad in the fridge."
	else
		was_unknown = true
		puts "I'm sorry but I don't understand your request."
	end
	
	was_unknown
end

def service_need(state)
	case
	when state == "hungry" 
		want_more = "yes"
		while want_more == "yes"
			puts which_snack? ? "Do you want to try again?" : "Do you want more food?"
			want_more = gets.chomp
		end
		state = "" if want_more == "no"
	when state == "thirsty" 
		puts "I would have to refer you to the nearest bar."
		state = "done"
	else
		puts "May I can be of assistance (hungry/thirsty/done)?"
		state = gets.chomp
	end
	state
end

state = "" 
until state == "done" 
	state = service_need(state)	
end
puts "Thank you for using my services."


# One path could output the following:
#
# May I can be of assistance (hungry/thirsty/done)?
# hungry
# What would you like to eat (apple, sandwich, salad)?
# apple
# There are apples in the fruit basket in the lounge.
# Do you want more food?
# no
# May I can be of assistance (hungry/thirsty/done)?
# thirsty
# I would have to refer you to the nearest bar.
# Thank you for using my services.