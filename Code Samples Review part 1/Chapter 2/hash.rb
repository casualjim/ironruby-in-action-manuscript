hash = { :hello => hello, :string_value => "a string value in the hash", :int_value => 3}

puts hash[:hello]
puts hash[:string_value]
puts "a numeric value of #{hash[:int_value]} in the hash"

# Outputs the following:
# 
# Hello, World!!!
# a string value in the hash
# a numeric value of 3 in the hash