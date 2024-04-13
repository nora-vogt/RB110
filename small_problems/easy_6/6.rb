=begin
Input:
  - array
  - array
Output:
  - single array, duplicate values removed

Rules:
- Args will be two arrays
- Return a new array containing all values from original arrays, duplicates removed

EXAMPLES:
merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]

DATA STRUCTURE:
- start: two arrays
- end: one array

ALGORITHM:
Given two arrays, "array_one", "array_two"
- concatenate array_one and array_two into one array
- remove duplicate values from new array
=end
# Original Solution
def merge(array_one, array_two)
  (array_one + array_two).uniq
end

# Manually
def merge(array_one, array_two)
  result_array = array_one.dup # add all elements from first array to a new array
  index = 0
  loop do
    result_array << array_two[index] unless result_array.include?(array_two[index])
    index += 1
    break if index == array_two.size
  end
  result_array
end

# LS Solution
def merge(array_1, array_2)
  array_1 | array_2
end

# Alternates
def merge(array_1, array_2)
  array_1.union(array_2)
end

p merge([1, 3, 5], [3, 6, 9]) == [1, 3, 5, 6, 9]

# Using splat operator to pass in any number of arrays
# splat will pass in an array of given args

def merge(*arrays) # => [arr1, arr2, arr3 ...]
  p arrays # => [1, 3, 5], [3, 6, 9], [6, 10, 2]
  arrays.inject(:|)
end

p merge([1, 3, 5], [3, 6, 9], [6, 10, 2]) == [1, 3, 5, 6, 9, 10, 2]


def splat_test(*args)
  p args
end

splat_test(1, 2, 3) # => [1, 2, 3]
splat_test(['abc']) # => [["abc"]]
splat_test('hello', 'world') # => ["hello", "world"]