=begin
Fibonacci

Input:
- integer (representing number of digits)

Output:
- output (representing index)

Rules:
- The Fibonacci series starts with two 1s, and each subsequent number is the sum of the previous two numbers
- The first Fibonacci number has index 1
- Method should return the index of the first number from Fibonacci series that has the number of digits specified as an argument
- index for this count starts from 1, not zero, so add 1 to array index position of element
- argument is always >= 2

# EXAMPLES

find_fibonacci_index_by_length(2) == 7          
  first number with 2 digits
  # 1 1 2 3 5 8 13 = 7th index position (index starts from 1)


find_fibonacci_index_by_length(3) == 12 
  first number with three digits       
  # 1 1 2 3 5 8 13 21 34 55 89 144 = 12 (index starts from zero)

find_fibonacci_index_by_length(10) == 45
  # first number with 10 digits
find_fibonacci_index_by_length(100) == 476
find_fibonacci_index_by_length(1000) == 4782
find_fibonacci_index_by_length(10000) == 47847

Making Fibonacci series:
[1, 1] 
add last two
1 + 1 => 2

[1, 1, 2]
add last two
1 + 2 = 3

[1, 1, 2, 3]
add last two
2 + 3 = 5

DATA STRUCTURE:
start: integer
middle: array of fibonacci numbers
end: integer (length of array)

ALGORITHM:
Given an integer, "number_of_digits"
- initialize array "fibonacci" to array containing 1, 1
- generate a list of fibonacci numbers
  - start a loop
    - initialize variable "next_num" to 0
    - sum last two items in "fibonacci", assign to "next_num"
    - add "next_num" to fibonacci
    - check the number of digits in "next_num"
        - break sum into an array of digits, get lenth of array
      - if match, stop iterating and return length of "fibonacci"
      - otherwise, add sum to "fibonacci"
=end

# def find_fibonacci_index_by_length(number_of_digits)
#   fibonacci = [1, 1]
#   loop do
#     next_num = fibonacci.last(2).sum
#     fibonacci << next_num
#     break if next_num.digits.size == number_of_digits
#   end
#   p fibonacci.length
# end

# Refactor - #to_s is much faster than #digits
# also made break condition >= to avoid infinite loop, if there is no number that matches our target number of digits
def find_fibonacci_index_by_length(number_of_digits)
  fibonacci = [1, 1]
  loop do
    next_num = fibonacci.last(2).sum
    fibonacci << next_num
    break if next_num.to_s.size >= number_of_digits
  end
  p fibonacci.length
end

p find_fibonacci_index_by_length(2) == 7
p find_fibonacci_index_by_length(3) == 12      
p find_fibonacci_index_by_length(10) == 45
p find_fibonacci_index_by_length(100) == 476
p find_fibonacci_index_by_length(1000) == 4782
p find_fibonacci_index_by_length(10000) == 47847