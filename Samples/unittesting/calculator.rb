class CalculatorOperation
  
  def initialize(left)
    @left = left
  end
  
  def add(right)
    @left + right
  end
  
  def sub(right)
    @left - right
  end

end