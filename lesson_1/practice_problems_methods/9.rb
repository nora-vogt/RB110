# What is the return value of map in the following code? Why?

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

# => [nil, 'bear']

# map will return a new Array, comprised of elements returned by the block. On the first iteration, the block returns nil because the if condition evaluates as false, and there is no else statement specified. On the second iteration, `value`.size > 3` returns true, and the code following the if branch is executed, making the reference to `value` the last evaluated statement that is returned by the block.


# NOTES FROM SOLUTION:
# When none of the conditions in an if statement evalautes as true, the if statement itself returns nil.