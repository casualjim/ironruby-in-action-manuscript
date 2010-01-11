require 'rubygems' unless defined?(Gem)
require 'shoulda'
require File.dirname(__FILE__) + '/calculator.rb'

class TestAddition < Test::Unit::TestCase
  
  context "A calculator operation" do
    setup do
      @calc = CalculatorOperation.new(2)
    end

    should "add a second number correctly" do
      res = @calc.add 2
      assert_equal 4, res
    end

    should "substract a second number correctly" do
      res = @calc.sub 1
      assert_equal 1, res
    end
    
  end
end