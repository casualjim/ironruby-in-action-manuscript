a = 73

6.times do 
	puts "Value of a: #{a}, Class of a: #{a.class}"
	a *= a
end

a = a/45.938

puts "\nValue of a: #{a}, Class of a: #{a.class}" 

# Outputs the following:
#
# Value of a: 73, Class of a: Fixnum
# Value of a: 5329, Class of a: Fixnum
# Value of a: 28398241, Class of a: Fixnum
# Value of a: 806460091894081, Class of a: Bignum
# Value of a: 650377879817809571042122834561, Class of a: Bignum
# Value of a: 422991386556309150149363832086603107763045099853453376062721, Class of a: Bignum
#
# Value of a: 3.89485204190058e+117, Class of a: Float