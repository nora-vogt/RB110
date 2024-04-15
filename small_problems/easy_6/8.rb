=begin
Input:
- array

Output:
- Integer (duplicate value)

Given an array where every element except one occurs exactly one time, find the element that is a duplicate (occurs twice).

Rules:
- every value except one occurs exactly once
- one value occurs twice

Qs
- will arrays always contain Integers, or other types too?
- what should an empty array return?

EXAMPLES:
[1, 5, 3, 1]

[1, 1, 3, 5]

Data structure:
start: array
middle: integer for comparison
end: integer

ALGORITHM:
Given an array, "array"
- sort the array in ascending order
- create "index", assign to 1
- create "prior_nums", assign to new array containing array[0]
- create "duplicate", assign to nil
- start a loop, iterate until index == array.size OR duplicate is not nil
  - get number at index position "index" in "array"
  - check if prior_nums includes current number
  - if yes,
    - assign number to "duplicate"
    - stop iterating
  - if no, add current number to "prior_nums"
  - increment index by 1
- return duplicate
=end

# Original Solution (matches Further Exploration)
def find_dup(array)
  prior_nums = array.take(1) # returns first element in a new array
  index = 1
  duplicate = nil
  loop do
    duplicate = array[index] if prior_nums.include?(array[index])
    prior_nums << array[index]
    index += 1
    break if index == array.size || duplicate
  end
  duplicate
end

# LS Solution
def find_dup(array)
  array.find { |element| array.count(element) == 2 }
end

# # Cool solution - Enumerable#tally
def find_dup(array)
  array.tally.key(2)
end

# Enumerable#tally returns a new hash, where keys are each unique element in caller, and values are the count of that element in caller
# chain #key to return the key associated with the count of 2




p find_dup([1, 5, 3, 1]) == 1
p find_dup([18,  9, 36, 96, 31, 19, 54, 75, 42, 15,
          38, 25, 97, 92, 46, 69, 91, 59, 53, 27,
          14, 61, 90, 81,  8, 63, 95, 99, 30, 65,
          78, 76, 48, 16, 93, 77, 52, 49, 37, 29,
          89, 10, 84,  1, 47, 68, 12, 33, 86, 60,
          41, 44, 83, 35, 94, 73, 98,  3, 64, 82,
          55, 79, 80, 21, 39, 72, 13, 50,  6, 70,
          85, 87, 51, 17, 66, 20, 28, 26,  2, 22,
          40, 23, 71, 62, 73, 32, 43, 24,  4, 56,
          7,  34, 57, 74, 45, 11, 88, 67,  5, 58]) == 73