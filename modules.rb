module Foo
  module ClassMethods
    def output
      puts "I'm a class method on module Foo"
    end
  end
  
  # inclusion hook, when this module gets included in a class
  # it will call this method afterwards to do some post processing.
  # in our case that means extending the class this module is being included in
  # with the methods that live in the ClassMethods module
  def self.included(base)
    base.extend(ClassMethods)
  end
end

module Bar
	module ClassMethods
    def output
  	  puts "I'm a class method on module Bar"
    end
  end
end 

class FooBaz
  
  include Foo
end

class BarBaz
  include Bar
  extend Bar::ClassMethods
end

FooBaz.output
BarBaz.output