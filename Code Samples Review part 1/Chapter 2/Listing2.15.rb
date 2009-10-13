require 'Listing2.14' 

dir = Dir.open('.')
files = dir.reject { |entry| entry.slice(0, 1) == '.' || entry.slice(entry.length() - 4, entry.length()) != '.txt' }
lists = files.collect do |file| 
	CsvRecord.build_from(file) 
	eval(File.basename(file, '.txt').capitalize).populate
end

list = lists[0]       
puts list[0].to_s
puts list[1].inspect

list.each do |person|
	result = person.name      
	if person.age < 18
		result << " is under 18"
	else
		result << " is over 18"
	end
	lbs = person.weight * 2.2  
	result << " and weighs #{lbs.floor} lbs"
	p result
end

places = lists[1]
puts places[0]

places.each do |place|
	puts "#{place.name} is #{place.description}"
end

# Generates the following output:
#
# <People: name=Smith, John age=35 weight=80 height=1m85>
# <People: name=Peters, Anne age=49 weight=68 height=1m65>
# "Smith, John is over 18 and weighs 176 lbs"
# "Peters, Anne is over 18 and weighs 149 lbs"
# "Jackson, James is over 18 and weighs 198 lbs"
# "Wilkinson, Tanya is under 18 and weighs 138 lbs"
# <Places: name=Wellington description=home and capital>
# Wellington is home and capital
# Auckland is the largest city in NZ
# Christchurch is the largest city on the south island

