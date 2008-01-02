def output
	puts "About to execute given block"
	
	yield if block_given? # execute the block if one was given
	
	puts "After executing the block"
end

output { puts "Hello, World!!!" }

puts "Executing method without a block"
output

# Outputs the following:
#
# About to execute given block
# Hello, World!!!
# After executing the block
# Executing method without a block
# About to execute given block
# After executing the block