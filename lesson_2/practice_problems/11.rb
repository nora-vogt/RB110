# Given the following data structure use a combination of methods, including either the select or reject method, to return a new array identical in structure to the original but containing only the integers that are multiples of 3.

# [[], [3, 12], [9], [15]]

arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

result = arr.map do |sub_array|
  sub_array.select {|int| int % 3 == 0}
end

p result
p result == [[], [3, 12], [9], [15]] # true


# attempt with #reject

reject_result = arr.map do |sub_array|
  sub_array.reject {|int| int % 3 != 0}
end

p reject_result
p reject_result == [[], [3, 12], [9], [15]] # true