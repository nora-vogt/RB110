require 'pry'
require 'pry-byebug'
=begin
Write a method that takes an Array of numbers, and returns an Array with the same number of elements, and each element has the running total from the original Array.

PROBLEM:
Input:
  - an Array

Output:
  - an Array, with elements reflecting the running total

Explicit Rules:
  - A running total is the sum of all values in a list up to and including the current element. 
    - For example: 
    [14, 11, 7, 15, 20]
    - at index 2 (element value 7), the running total is 32 (14 + 11 + 7)
    - at index 3 (15), the running total is 47 (14 + 11 + 7 + 15)
  - The new array should have the same number of elements as the original array

Implicit Rules:
  - The first element in the new array will be the same as the first element in the original array
  - Passing in an empty array should return an empty array
  - Passing in an array containing on element should return a new array containing that same value

Mental Model:
  Given an array, return a new array. Each element of the new array will be the sum of all numbers in the original array starting from index 0 up to and including the current index position. 

EXAMPLES:
running_total([2, 5, 13]) == [2, 7, 20]
running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
running_total([3]) == [3]
running_total([]) == []

A running total is the sum of all values in a list up to and including the current element. 
Thus, the running total when looking at index 2 of the array [14, 11, 7, 15, 20] is 32 (14 + 11 + 7), while the running total at index 3 is 47 (14 + 11 + 7 + 15).

[2, 5, 13] == [2, 7, 20]
index 0: 2 => 2
index 1: 2 + 5 => 7
index 2: 2 + 5 + 13 => 20

[3] == [3]
index 0: 3 => 3

[14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
index 0: 14 => 14
index 1: 14 + 11 => 25
index 2: 14 + 11 + 7 => 32
index 3: 14 + 11 + 7 + 15 => 47
index 4: 14 + 11 + 7 + 15 + 20 => 67

DATA STRUCTURE:
- An Array - add the running total elements

ALGORITHM:
Given an array,
1. Initialize a variable "sum" to reference 0
2. Initialize a variable "result_array" to reference an empty array
3. Iterate through the given array
  1. Add the current element to running_total
  2. Add running_total to the result_array
  3. Repeat steps 1-2 for all elements in the given array
4. Return the result_array

CODE:
- Notes: Perhaps use #map in solution
=end


# def running_total(array)
#   sum = 0
#   array.map { |number| sum += number }
# end

# Further Exploration:
  # Try solving this problem using Enumerable#each_with_object or Enumerable#reduce (note that Enumerable methods can be applied to Arrays).

# Enumerable#each_with_object
# can't sum arr - because that's summing the new incremented array
# This would be easy using a sum variable like the last problem, but is there a way to do it without that - just relying on the new array returned by each_with_object?

# def running_total(array)
#   sum = 0
#   array.each_with_object([]) do |number, arr|
#     arr << (sum += number)
#   end
# end


# Enumerable#reduce
# reduce passes the return value of the block to sum
# def running_total(array)
#   result_array = []
#   array.reduce(0) do |sum, number|
#     result_array << sum + number
#     sum + number
#   end
#   result_array
# end

# Enumerable#inject but passing an array argument instead
def running_total(array)
  total = 0
  array.inject([]) do |new_arr, number|
    new_arr << total += number
  end
end


p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []