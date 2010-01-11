require 'rubygems' unless defined?(Gem)
require 'test/unit'
require File.dirname(__FILE__) + '/calculator.rb'

class TestAddition < Test::Unit::TestCase
  
  def setup
    @calc = CalculatorOperation.new(2)
  end
  
  def test_add
    res = @calc.add(2)
    assert_equal 4, res
  end
  
  def test_substract
    res = @calc.sub(1)
    assert_equal 1, res
  end
end