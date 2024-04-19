=begin
PROBLEM
Input: 
  - array
  - value to search for
Output:
  - Boolean

Rules:
- Do not use Array#include? in solution
- Given an empty array, should return false (there is no object inside an empty array)

Write a custom include? method. It takes two arguments: 1) an array 2) the value to search for. Return true if the value is prsent in array, return false if not.

EXAMPLES
include?([1,2,3,4,5], 3) == true
include?([1,2,3,4,5], 6) == false
include?([], 3) == false
include?([nil], nil) == true
include?([], nil) == false

DATA STRUCTURE
start: array
middle: array
end: boolean

ALGORITHM
Given an array, "array" and a value, "element"
- initialize "match" to false
- initialize "counter" to 0
- start a loop
  - iterate while counter < size of array AND while match is false
  - check if item at index counter in array is equal to value of element
    - if no, continue
    - if yes, reassign "match" to true and break from loop
  - increment counter by 1
- return match
=end

# def include?(array, element)
#   match = false
#   counter = 0
#   loop do
#     break if match || counter == array.size
#     match = true if array[counter] == element
#     counter += 1
#   end
#   match
# end

# # # LS Solution
# # find_index (alias: Array#index) - return the index of the first occurence of given value, or nil if value is not present in array. Add !! to return the boolean equivalent.
# def include?(array, element)
#   !!array.find_index(element)
# end

# # Solution #2
# # #select will return either an empty array (element is not included), or an array with 1 element (element is included in array). Chain #empty? to check if the new array returned by #select is empty (no match), which will return a Boolean. However, this boolean will be true if element is not included, false if it is included. Add ! to the return value, to return the opposite boolean value.

# def include?(array, element)
#   !array.select { |item| item == element }.empty?
# end

# Alternates
def include?(array, element)
  array.count(value) > 0
end

def include?(array, element)
  array.any?(element)
end

p include?([1,2,3,4,5], 3) == true
p include?([1,2,3,4,5], 6) == false
p include?([], 3) == false
p include?([nil], nil) == true
p include?([], nil) == false