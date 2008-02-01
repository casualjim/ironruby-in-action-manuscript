text = "This is the sample text for the ironruby in action book"
re_literal1 = /ironruby in action/
re_literal2 = %r{the sample text}
re = Regexp.new "book$"

if text =~ re_literal1
	title = re_literal1.match(text)[0]
else
	title = "No match for re literal 1"
end

if text =~ re_literal2
	sample = re_literal2.match(text)[0]
else
	sample = "No match for re literal 2"
end

if text =~ re
	ends = "the sample text ends with book"
else
	ends = "the sample text doesn't end with book"
end
	

puts "title match: #{title}"
puts "sample match: #{sample}"
puts ends

# Outputs the following
#
# title match: ironruby in action
# sample match: the sample text
# the sample text ends with book