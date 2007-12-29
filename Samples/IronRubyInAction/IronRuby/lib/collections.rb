def hello
	"Hello, World!!!" 
end

array = ["first element", [1, 2, 3], 3, hello, "one to last element", "last element"]

# get the 4the element in the list.
# it's an expression which we're going to execute
puts array[3]

# get the 2 last elements (start counting at the second to last object)
puts array[-2,2].join(", ")

# display the child array
puts array[1].join(', ')

# get the elements from the hello world until the end of the array
puts array[2...array.length].join(', ')

# Outputs the following:
#
# Hello, World!!!
# one to last element, last element
# 1, 2, 3
# 3, Hello, World!!!, one to last element, last element

hash = { :hello => hello, :string_value => "a string value in the hash", :int_value => 3}

puts hash[:hello]
puts hash[:string_value]
puts "a numeric value of #{hash[:int_value]} in the hash"

# Outputs the following:
# 
# Hello, World!!!
# a string value in the hash
# a numeric value of 3 in the hash