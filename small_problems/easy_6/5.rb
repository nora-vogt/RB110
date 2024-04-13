=begin

Write a method that takes an Array and returns a new Array populated by the elements from the original array in reverse order. Do not mutate the original array.

Input: array
Output: new array (containing same elements as input array)

Rules:
- return a new array
- new array should contain original objects from input array, just in reverse order
- do not mutate the input array
- do not use Array#reverse/reverse! or method from prior exercise
- given an empty array should return a new empty array
- If the element in array is a string or nested collection, do not reverse the order of those elements. ex: ['abc'] => ['abc'] - don't reverse string. ['abc', 'cde'] => ['cde', 'abc']

EXAMPLES:
[1, 2, 3, 4] - original array
[4, 3, 2, 1] - new array, same objects

first iteration
swap 1, 4
[4, 2, 3, 1]

second iteration
swap 2, 3
[4, 3, 2, 1]

start index: 0, 1
array size = 4
iterate while start index < array.size / 2


[1, 2, 3]
first iteration
index = 0
swap 1, 3
[3, 2, 1]
done

array size = 3
3 / 2 = 1

# DATA STRUCTURE
start: array
middle: new array
end: new array

# ALGORITHM
Given an array,
- make a shallow copy of the array, assign to "copy_array"
- create "first_index", assign to 0
- create "second_index", assign to -1
- start a loop, iterate while first_index < copy_array length
  - use multiple assignment to swap element at first_index in copy_array with element at second_index in copy_array
    - a, b = b, c =>
  - increment first_index by 1
  - decrement second_index by -1
- return copy_array
=end

def reverse(array)
  copy_array = array.dup
  first_index = 0
  second_index = -1
  while first_index < copy_array.size / 2
    copy_array[first_index], copy_array[second_index] = copy_array[second_index], copy_array[first_index]
    first_index += 1
    second_index -= 1
  end
  copy_array
end

# # LS Solution - Array#reverse_each
# # #reverse_each iterates over array elements backwards
def reverse(array)
  result_array = []
  array.reverse_each { |element| result_array << element }
  result_array
end

# Further Exploration
# Using Enumerable#reduce (#inject)
# reduce with initial operand - and Array#unshift (alias: #prepend) method passed as a symbol method name
  # operands for #reduce are [] and every element in array
  # reduce will combine operands by the given symbol method name

def reverse(array)
  p array.reduce([], :unshift)
end

# Using Enumerable#each_with_object
def reverse(array)
  array.each_with_object([]) do |element, new_array|
    new_array.prepend(element)
  end
end

p reverse([1,2,3,4]) == [4,3,2,1]          # => true
p reverse(%w(a b e d c)) == %w(c d e b a)  # => true
p reverse(['abc']) == ['abc']              # => true
p reverse([]) == []                        # => true

p list = [1, 3, 2]                      # => [1, 3, 2]
p new_list = reverse(list)              # => [2, 3, 1]
p list.object_id != new_list.object_id  # => true
p list == [1, 3, 2]                     # => true
p new_list == [2, 3, 1]                 # => true