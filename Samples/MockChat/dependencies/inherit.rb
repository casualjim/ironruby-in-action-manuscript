class Parent
    
	class << self
	
		def add_value(key, value)
			@values ||= {}
			@values[key] = value
		end
		
		def values
			vals = {}
			return @values unless superclass.respond_to? :values
			@values.merge(superclass.values)
		end
		
		def hello
			puts values.collect{|k,v| v}.join("\n")			
		end
	end
	
	add_value :parent, "Hello from parent"
end

class Child < Parent
	add_value :child, "Hello from child"
end

class GrandChild < Child
	add_value :grand_child, "Hello from grandchild"
end

puts "Parent:"
Parent.hello
puts "Child:"
Child.hello
puts "Grand child:"
GrandChild.hello