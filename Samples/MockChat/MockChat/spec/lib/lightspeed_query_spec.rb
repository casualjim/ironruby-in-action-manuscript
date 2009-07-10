require File.dirname(__FILE__) + "/../spec_helper"
require 'lightspeed_support'

describe Lightspeed::Finder::RubyQueryExpression do

  # Called before each example.
  before(:each) do
    # Do nothing
  end

  # Called after each example.
  after(:each) do
    # Do nothing
  end

  it "should not raise an error when initialized" do
    lambda { Lightspeed::Finder::RubyQueryExpression.new }.should_not raise_error
  end

  describe "initialized without a block" do

    before(:each) do
      @expr = Lightspeed::Finder::RubyQueryExpression.new
      @expr.a(:name)
    end

    it "should set the attribute name" do

      @expr.attribute.should eql_clr_string(:name)
    end

    it "should set the operator to equals when a string is given" do
      @expr == "something"
      @expr.operator.should == RelationalOperator.equal_to
    end

    it "should set the value to an array" do
      @expr == "something"
      @expr.value.should == [LiteralExpression.new("something")]
    end

    #it "should set the operator to between when the == is called with a Range parameter" do
    #  @expr == 1..4
    #  @expr.operator.should == RelationalOperator.between
    #end
    #
    #it "should set the value to a 2 element array when the == is called with a Range parameter" do
    #  @expr == 1..4
    #  v = @expr.value
    #  v.size.should == 2
    #end
    #
    #it "should set the correct values in the 2 element array when the == is called with a Range parameter" do
    #  @expr == 1..4
    #  v = @expr.value
    #  v.first.should == 1
    #  v.last.should == 3
    #end

    it "should set the operator to LIKE" do
      @expr.like("something")
      @expr.operator.should == RelationalOperator.like
    end

    it "should set the operator to between" do
      @expr.between(1, 4)
      @expr.operator.should == RelationalOperator.between
    end

    it "should should have a literal value expression for the between operator" do
      @expr.between(1,4)
      @expr.value.first.should be_a_kind_of(LiteralExpression)
    end

    it "should should have a literal value expression for the equal_to operator" do
      @expr == "something"
      @expr.value.first.should be_a_kind_of(LiteralExpression)
    end

    it "should should have a literal value expression for the like operator" do
      @expr.like "something"
      @expr.value.first.should be_a_kind_of(LiteralExpression)
    end

    it "should should have a literal value expression for the in operator" do
      @expr.in [1, 3, 5]
      @expr.value.first.should be_a_kind_of(LiteralExpression)
    end

    it "should set the value to a 2 element array when the between operator is called" do
      @expr.between(1, 4)
      @expr.value.size.should == 2
    end

    it "should set the correct values in the 2 element array when the between operator is called" do
      @expr.between(1, 4)
      v = @expr.value
      v.first.value.should == 1
      v.last.value.should == 4
    end

    it "should set the operator to IN" do
      @expr.in [1,4,5]
      @expr.operator.should == RelationalOperator.in
    end

    it "should set the value to the provided array for the IN operator" do
      @expr.in [1,4,5]
      @expr.value.should == [1,4,5].collect { |c| LiteralExpression.new(c) }
    end

  end
end