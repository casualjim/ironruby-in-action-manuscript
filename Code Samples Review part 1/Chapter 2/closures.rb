def with_proc
    func = Proc.new { return "return from with_proc from inside Proc" }
    func.call # control leaves with_proc here
    return "return from with_proc"
end

def with_lambda
    func = lambda { return "return from lambda" }
    func.call # control does not leave with_lambda here
    return "return from with_lambda"
end


puts with_proc
puts with_lambda

# Outputs the following:
#
# return from with_proc from inside Proc
# return from with_lambda