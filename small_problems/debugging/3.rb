=begin
Valid Series?

- a valid series must contain exactly three odd numbers
- the numbers must sum to 47

Unfortunately, our last test case is not returning the expected result. Why is that?
=end

def valid_series?(nums)
  return false if nums.sum != 47

  odd_count = nums.count { |n| n.odd? }
  odd_count = 3 ? true : false
end

p valid_series?([5, 6, 2, 7, 3, 12, 4, 8])        # should return true
p valid_series?([1, 12, 2, 5, 16, 6])             # should return false
p valid_series?([28, 3, 4, 7, 9, 14])             # should return false
p valid_series?([20, 6, 9, 4, 2, 1, 2, 3])        # should return true
p valid_series?([10, 6, 19, 2, 6, 4])             # should return false

=begin
This code is producing an unexpected result for the last test case due to line 5, where variable assignment is used instead of what should be the equality comparison operator `==`:

`odd_count = 3 ? true : false`

This code reassigns the local variable `odd_count` to `3`. The return value of assignment is the assigned value `3`. `Integers` are truthy objects in Ruby, so the `odd_count = 3` evaluates as true, and the ternary operator returns `true`. This value is then returned by the `valid_series?` method.

This is why, even though the series in the last test case does not contain three odd numbers, the final test case returns `true`.

To fix this, we need to check for equality instead of performing variable assignment on line 5:

# TIME: 5:18
=end

def valid_series?(nums)
  return false if nums.sum != 47

  odd_count = nums.count { |n| n.odd? }
  odd_count == 3 ? true : false
end

p valid_series?([10, 6, 19, 2, 6, 4]) #== false

# Further Explanation
# The ternary operator on line 5 is not necessary, because `odd_count == 3` already returns a Boolean value. Once we have made it to this point in the method definition, we know the sum of the series does equal `47` (otherwise, the method would have returned on line 2), and `odd_count == 3` returning `true` or `false` tells us if the series satisfies the condition of containing exactly three odd numbers.

def valid_series?(nums)
  return false if nums.sum != 47

  odd_count = nums.count { |n| n.odd? }
  odd_count == 3
end

p valid_series?([5, 6, 2, 7, 3, 12, 4, 8]) == true
p valid_series?([1, 12, 2, 5, 16, 6]) == false
p valid_series?([28, 3, 4, 7, 9, 14]) == false
p valid_series?([20, 6, 9, 4, 2, 1, 2, 3]) == true
p valid_series?([10, 6, 19, 2, 6, 4]) == false

# All test cases are accurate with the change.