# What is the block's return value in the following code? 
# How is it determined? 
# Also, what is the return value of any? in this code and what does it output?

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

# The block's return value is the return value of the last evaluated expression within the block. In this case, that's the #odd? invocation, which returns a Boolean - true if the value of num is odd, and false if not. 
  # first iteration block returns => true
  # second iteration block returns => false
  # third iteration block returns = true

# The any? method will return true. 
# any? evaluates the return value of the block, and will return true if the block returns a truthy value on any iteration. In this case, the block returns true on the first and last iterations, meaning that any? will return true.

# CORRECTION FROM SOLUTION:
# Because the block returns true on the first iteration, any? will return true. any? will stop iterating at this point, because there is no need to evaluate the remaining items in the array. This code will only output 1. 