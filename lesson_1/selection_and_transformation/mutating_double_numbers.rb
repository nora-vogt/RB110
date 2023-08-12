def double_numbers!(numbers)
  counter = 0

  loop do
    break if counter == numbers.size

    numbers[counter] *= 2
    counter += 1
  end
  numbers
end

p my_numbers = [1, 4, 3, 7, 2, 6]
p double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]
p my_numbers

# REMEMBER! This works because Array#[]= isn't assignment, despite the = sign. It's a method that mutates it's calling array, and in this example, the method parameter numbers points to the same Array object that my_numbers points to.