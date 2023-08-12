fruits = ['apple', 'banana', 'pear']
transformed_elements = []
counter = 0

loop do
  current_element = fruits[counter]

  transformed_elements << (current_element + 's')  # appends transformed string into array

  count += 1
  break if counter == fruits.size
end

transformed_elements # => ["apples", "bananas", "pears"]