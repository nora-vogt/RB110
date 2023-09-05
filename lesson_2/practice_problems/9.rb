require 'pry'
# Given this data structure, return a new array of the same structure but with the sub arrays being ordered (alphabetically or numerically as appropriate) in descending order.


arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

p (arr.map do |sub_array|
    sub_array.sort {|a, b| b <=> a}
  end)


# Notes: 
  # "return a new array.. with subarrays [transformed]" should cue use of #map"
  # Array#sort with a block, we can change the order of a and b for descending sort order