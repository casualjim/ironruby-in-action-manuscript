plain_string = "Hello, World!!!"
string_with_escape = "Hello, World!!!\nI'm on a new line."
string_with_Q = %Q[Hello, World!!!]
string_with_interpolation = "I said; #{plain_string}"
string_with_document_here = <<STRING_LITERAL
Hello, World!!!
I'm on a new line
Look at me !!!
STRING_LITERAL

puts "Plain string: #{plain_string}"
puts "String with escape: #{string_with_escape}"
puts "String with %Q: #{string_with_Q}"
puts "String with interpollation: #{string_with_interpolation}"
puts "String with document here:\n#{string_with_document_here}"

# Outputs the following:
#
# Plain string: Hello, World!!!
# String with escape: Hello, World!!!
# I'm on a new line.
# String with %Q: Hello, World!!!
# String with interpollation: I said; Hello, World!!!
# String with document here:
# Hello, World!!!
# I'm on a new line
# Look at me !!!