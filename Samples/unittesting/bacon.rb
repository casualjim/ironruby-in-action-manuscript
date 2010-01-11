require 'rubygems' unless defined?(Gem)
require 'bacon'
require File.dirname(__FILE__) + '/calculator.rb'

describe "A calculator operation" do
  
  before do
    @calc = CalculatorOperation.new(4)
  end
  
  it "should add 2 numbers correctly" do
    @calc.add(4).should == 8
  end
  
  it "should subtract 2 numbers correctly" do
    @calc.sub(2).should == 2
  end
  
end