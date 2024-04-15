=begin
Input: array
Output: array (containing 2 nested arrays)

Rules:
- Return a new array containing two nested ararys
- First nested array should contain first half of elements from given array
- Second nested array should contain second half of elements from given array
- if given array has an odd number of elements, put the middle element in the first nested array
- Given one element, return that element in first nested array + empty array
- Given an empty array, return two empty nested arrays

Problem: Write a method that takes an array as an argument. Return a new array containing two nested arrays. The first nested array should contain the first half of elements from given array. The second nested arra should contain the second half of elements. If the given array has an odd number of elements, put the middle element in the first array.


EXAMPLES:
halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]

1 2 3 4 odd? - no
size = 4
4 / 2 = 2
2 in each nested array

halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]

1 5 2 4 3 odd? - yes
size = 5
5 / 2 = 2 + 1 (add 1 for middle num)
3 in first array, (size - 3 = 2) 2 in second array

halvsies([5]) == [[5], []]
1 odd? - yes
size = 1
1 / 2 = 0 + 1
1 in first array; size - 1 = 0 - 0 in second array


halvsies([]) == [[], []]


Data structure:
start: array
middle: nested arrays
end: nested arrays

ALGORITHM:
Given an array, "array"
- Create a new empty array, "result"
- Check if the size of the array is odd
  - If Yes:
    - assign to "first" -divide array size / 2, and add 1 - this will be the # of elements in first 'half'
    - assign to "second" - calculate array size - "first" - this will be # of elements in second 'half'
    - add "first" # of elements to a new array, push into "array"
    - add "second" # of elements to a new array, push into "array"
  - If No:
  - assign "half" to array size / 2
  - assign first "half" # of elements to new array, push into "array"
  - assign second "half" # of elements to new array, push into "array"
- return "result"
=end

# First solution
def halvsies(array)
  result = []
  half = array.size / 2
  if array.size.odd?
    result << array.first(half + 1)
    result << array.last(half)
  else
    result << array.first(half)
    result << array.last(half)
  end
  result
end

# Refactor
def halvsies(array)
  half = array.size / 2
  if array.size.odd?
    [array.first(half + 1), array.last(half)]
  else
    [array.first(half), array.last(half)]
  end
end

# LS Solution
def halvsies(array)
  middle = (array.size / 2.0).ceil # rounds up to nearest Integer
  first_half = array.slice(0, middle) # get the first half
  second_half = array.slice(middle, array.size - middle)
  [first_half, second_half]  
end

p halvsies([1, 2, 3, 4]) == [[1, 2], [3, 4]]
p halvsies([1, 5, 2, 4, 3]) == [[1, 5, 2], [4, 3]]
p halvsies([5]) == [[5], []]
p halvsies([]) == [[], []]

# Further Exploration
# The LS solution divides by 2.0 instead of 2, because diving by 2 performs Integer division - which will round down to the nearest whole number (ex: 5 / 2 = 2). Dividing by 2.0 performs Float division, which will return a precise float answer (5 / 2.0 = 2.5) that can then be rounded up using Float#ceil to get the first half (or half + 1) number of elements in both even and odd sized arrays.