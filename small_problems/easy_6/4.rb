require 'pry'
=begin
- Input:
   - array
- Output:
  - same array, with elements reversed

Rules:
- method should return the same given array object, mutated
- do not use Array#reverse or Array#reverse!
- given an empty array should return an empty array

EXAMPLES:
1 2 3 4 - length, 4
4 3 2 1 - same object

first:
swap 0 and -1
4 2 3 1

second:
swap 1 and - 2
4 3 2 1

how to know when to stop iterating?
  iterate length / 2 times


a b e d c - length, 5

swap 0 and -1
c b e d a

swap 1 and -2
c d e b a

3 stays in same place - middle

a, b = b, a




DATA STRUCTURE:
array all the way through

ALGORITHM:
Given an array, "array"
- create "first_index", assign to 0
- create "last_index", assign to -1
- start a loop - iterate array.length / 2 times
  - swap character at array[first_index] with array[last_index]
    - use multiple assignment a, b = b, c
  - increment first_index by 1
  - decrement last_index by 1
- stop looping after array.length / 2 times
- return array
=end

# def reverse!(array)
#   first_index = 0
#   last_index = -1
#   (array.length / 2).times do
#     array[first_index], array[last_index] = array[last_index], array[first_index]
#     first_index += 1
#     last_index -= 1
#   end

#   array
# end

# Alternate solution, using Array#map! to transform the array, and popping off the last element of a copy array on each iteration. #pop mutates the copied Array object only.
def reverse!(array)
  copy = array.dup
  array.map! { |element| copy.pop }
end

p list = [1,2,3,4]
p result = reverse!(list)
p result == [4, 3, 2, 1] # true
p list == [4, 3, 2, 1] # true
p list.object_id == result.object_id # true

p list = %w(a b e d c)
p reverse!(list) == ["c", "d", "e", "b", "a"] # true
p list == ["c", "d", "e", "b", "a"] # true

p list = ['abc']
p reverse!(list) == ["abc"] # true
p list == ["abc"] # true

p list = []
p reverse!(list) == [] # true
p list == [] # true