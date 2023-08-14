require 'pry'
# What happens when we modify an array while we are iterating over it? What would be output by this code?
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  binding.pry
  numbers.shift(1)
end

p numbers

# We can get unexpected results when modifying an array while iterating over it.

# In this code, #each is invoked on the array referenced by numbers. On the first iteration, the first element in the array is passed to the block parameter number. 
  # On the first iteration:
    # the #p invocation will the value of number, 1
    # numbers.shift(1) will destructively remove the first element in the numbers array
    # new value of numbers: [2, 3, 4]
  # On the second iteration:
    # The value passed to number is the value of the 3rd element - the Integer 3. The integer 2 has been skipped.
    # #p number will output 3
    # numbers.shift(1) will destructively remove the first element in the numbers array, which is now the integer 2
# After the second iteration, #each stops iterating. numbers now has a value of [3, 4]

# What's happening here is that numbers.shift(1) removes the first element in the numbers array. The element that was previously second in the array becomes the first element. [1, 2, 3, 4] -> [2, 3, 4]

# However, #each has already iterated over the first element in the array, so it moves on to the second iteration. This is why the integer 2 is never passed to the block parameter- it became the new first element, and the first element iteration has already completed.

# On the second iteration, the same pattern occurs: 3 (the new second element in numbers) is passed to the block parameter.
  # p outputs the value of number - 3
  # numbers.shift(1) removes the first element - 2
  # numbers now has a value of [3, 4]

# each can't move on to the third iteration, because numbers now references a two element array [3, 4]  - there is no third element. So, #each returns, and when we check the value of the numbers array, we see [3, 4] as its value.  


# What would be output by this code?
# numbers = [1, 2, 3, 4]
# numbers.each do |number|
#   p number
#   numbers.pop(1)
# end

# first iteration:
  # number == 1
  # p number -> outputs 1
  # numbers.pop(1) -> removes 4 from the array
  # value of numbers -> [1, 2, 3]

# second iteration:
  # number == 2
  # p number -> outputs 2
  # numbers.pop(1) -> removes 3
  # value of numbers -> [1, 2]
  # #each returns, as there is no third element to iterate on


# NOTES FROM SOLUTION:
 # The loop counter used by #each is compared against the current length of the array, rather than its original length
 # Iterators operate on the original array in real time - not a copy