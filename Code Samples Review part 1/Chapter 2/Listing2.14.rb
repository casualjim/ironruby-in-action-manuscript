class CsvRecord
    
	def self.build_from(file)
		data = File.new(file)
		header = data.gets.chomp
		data.close
		class_name = File.basename(file,".txt").capitalize  

		klass = Object.const_set(class_name, Class.new)
		names = header.split(",")

		klass.class_eval do

			attr_accessor *names
			
			define_method(:initialize) do |*values| 
				names.each_with_index do |name,i| 
					instance_variable_set("@"+name, values[i])
				end
			end
			
			define_method(:to_s) do
				str = "<#{self.class}:"
				names.each {|name| str << " #{name}=#{self.send(name)}" }
				str + ">"
			end
			
			alias_method :inspect, :to_s
		end

		def klass.populate
			array = []
			data = File.new(self.to_s.downcase+".txt")
			data.gets  # throw away header
			data.each do |line| 
				line.chomp!   
				values = eval("[#{line}]")
				array << self.new(*values)
			end
			data.close
			array
		end

		klass
	end
    
end