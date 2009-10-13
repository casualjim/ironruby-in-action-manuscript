$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'listing1.9'

class HelloWorldTest < Test::Unit::TestCase
	
	def test_print
		hw = HelloWorld.new    
		assert_equal 'Hello world !!!', hw.print, "The strings should be equal" 
	end
	
end