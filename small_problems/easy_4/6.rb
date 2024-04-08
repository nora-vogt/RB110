# RUNNING TOTALS

=begin
# PROBLEM
Input:
  - array of integers
Output:
  - array of integers (running total)

Rules:
  - A running total is the sum of all consecutive values up to and including the current element. ex: [1, 3, 5] -> 1; 1 + 3 = 4; 4 + 5 = 9
  - The running total array will sum the elements in that array
  - Given an empty array argument should rreturn an empty array
  - Giving a 1-element array as an argument should return a 1-element array
  - Returned array must have same number of elements as starting array

Qs
- Should method return the original array or a new array? (seems like a new array)


# EXAMPLES
running_total([2, 5, 13]) == [2, 7, 20]

index 0: 2 -> new array [2]
index 1: 5 -> new array [2, 2 + 5] -> [2, 7]
index 2: 13 -> new array [2, 7, 7 + 13] -> [2, 7, 20]

running_total([3]) == [3]
index 0: 3 -> new array [3]

# DATA STRUCTURE
start: array
end: new array

# ALGORITHM
Given an array, 'start_arr'
- create a var 'total_arr' to reference an empty array
- Iterate through 'start_arr'
  - On first iteration: Add element at index 0 to total_arr
  - On subsequent iterations:
    - Add element at current index + the element at index - 1 in total_arr to total_arr
- return running total
=end

# Original Solution
# def running_total(start_arr)
#   total_arr = []
#   start_arr.each_with_index do |number, index|
#     if index == 0
#       total_arr << number
#     else
#       total_arr << number + total_arr[index - 1]
#     end
#   end
#   total_arr
# end


# LS SOLUTION
# def running_total(array)
#   sum = 0
#   array.map { |number| sum += number }
# end

# FURTHER EXPLORATION
# Use Enumerable#each_with_object
# def running_total(array)
#   sum = 0
#   array.each_with_object([]) do |number, new_arr|
#     new_arr << sum += number
#   end
# end

# Use Enumerable#reduce
# def running_total(array)
#   sum = 0
#   array.inject([]) do |new_arr, num|
#     new_arr << sum += num
#   end
# end

# Alternative
def running_total(array)
  array.map.with_index do |num, index|
    array[0..index].inject(:+)
  end
end

p running_total([2, 5, 13]) == [2, 7, 20]
p running_total([14, 11, 7, 15, 20]) == [14, 25, 32, 47, 67]
p running_total([3]) == [3]
p running_total([]) == []