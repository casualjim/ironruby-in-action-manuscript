#dynamic but strong typed.

a = 5
a = 5 + 5

#the following is valid because a number 
#implements a to_s method that will be called 
#to convert this value to a string
puts "the type: #{a.class.to_s}, the value: #{a}" # a.to_s => "10"

# The example below is a valid use in dynamic languages
a = "123" 

# This is valid because a is a string and has support for the length method
puts "the type: #{a.class.to_s}, the value: #{a.length}" # outputs String, 3

# The following is invalid because a number doesn't know
# how to perform an addition with a value of type string so it will throw a TypeError.
# And the program stops working at this point because of the invalid type
a = 5 + a 

