# What is the return value of the following code? Why?

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

# output:
# 2
# 3

# => [1, nil, nil]

# The #map invocation will return a new array with a value of `[1, nil, nil]`. #map returns a new array comprised of elements returned by the block. On the first iteration, `num > 1` evaluates as false, so the `else` branch is executed, returning the value of `num` which is `1`. 

# On the second and third iterations, `num > 1` evaluates as true, so the code following the `if` branch is executed. This results in 2 and 3 being output. The `#puts` invocation is the last evalauted expression, and `#puts` always returns `nil`, so `nil` is returned by the block on the second and final iterations.