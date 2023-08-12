# What is the return value of the select method below? Why?
[1, 2, 3].select do |num|
  num > 5
  'hi'
end

# The select method will return a new array with a value of [1, 2, 3]. This is because the last evaluated statement within the block is the String 'hi'. Strings are truthy, so the block returns a truthy value for each iteration, meaning all elements from the calling array will be selected.