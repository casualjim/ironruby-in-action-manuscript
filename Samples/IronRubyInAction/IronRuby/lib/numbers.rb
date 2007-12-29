a = 70

6.times do 
	puts "Value of a: #{a}, Class of a: #{a.class}"
	a *= a
end

a = a/45.938

puts "\nValue of a: #{a}, Class of a: #{a.class}" 

# Outputs the following:
#
# Value of a: 70, Class of a: Fixnum
# Value of a: 4900, Class of a: Fixnum
# Value of a: 24010000, Class of a: Fixnum
# Value of a: 576480100000000, Class of a: Bignum
# Value of a: 332329305696010000000000000000, Class of a: Bignum
# Value of a: 110442767424392064630529920100000000000000000000000000000000, Class of a: Bignum
#
# Value of a: 2.65523202498114e+116, Class of a: Float