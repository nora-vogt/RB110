# What is the return value of reject in the following code? Why?

[1, 2, 3].reject do |num|
  puts num
end

# [1, 2, 3]
# Array#reject returns a new array comprised of elements from the original array for which the block returns a falsy value (false or nil). In this case, the #puts invocation is the last evaluated expression, and #puts always returns nil. nil is falsy, meaning that the block returns a falsy value for every iteration, so all elements from the original array will be included in the new array.