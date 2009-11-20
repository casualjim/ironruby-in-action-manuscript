class Array
  
  def rotate!(n=1)
    (n%4).times {self.replace(self.reverse.transpose)}
    self
  end

end