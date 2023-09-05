require 'pry'
# Given this data structure write some code to return an array which contains only the hashes where all the integers are even.

# Iterate through the array
# Iterate through each hash element
  # Check all the values in the hash
  # If all hash values are even, select that hash for the new array
  # If all hash values are not even, do not select that hash for the new array

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

result = arr.select do |element|
  element.values.flatten.all? {|int| int.even?}
end

p result


# LS Solution
new_arr = arr.select do |hash|
  hash.all? do |_, value| # iterate through the value arrays; if the nested all? block returns true for each iteration, the outer all? returns true - the hash is selected
    value.all? do |int| # check if all integers in the value arrays are even; all? returns a boolean to the outer all?
      int.even?
    end
  end
end

p new_arr