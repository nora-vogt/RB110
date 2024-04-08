=begin
List of Digits

PROBLEM:
Write a method that takes a positive integer argument, and returns an array containing a list of digits in the integer.

Input:
- Integer

Output:
- array of digits from integer

Rules:
- a positive integer will be given as argument
- digits should appear sequentially in new array

EXAMPLES:
To get each place, 
  - divide number by 10
  - remainder is the digit in target place
  - quotient is what's left
  
  take the remainder of dividing by 10.

puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true


12345.divmod(10) = [1234, 5]
1234.divmod(10) = [123, 4]
123.divmod(10) = [12, 3]
12.divmod(10) = [1, 2]
1.divmod(10) = [0, 1]
0.divmod(10) = [0, 0]

append all remainders to an empty array
reassign target number to quotient


puts digit_list(7) == [7]                     # => true

puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true

puts digit_list(444) == [4, 4, 4]             # => true

ALGORITHM:
Given an integer, "integer"
- create variable "digits", assign to empty array
- start a loop
  - divide integer by 10, get quotient and remainder
  - reassign integer to the quotient
  - add remainder to the beginning of digits array
- stop looping when integer == 0
- return digits
=end

# Original Solution
def digit_list(integer)
  digits = []
  while integer > 0
    quotient, remainder = integer.divmod(10)
    integer = quotient
    digits.unshift(remainder)
  end
  
  digits
end

# # Refactor
def digit_list(integer)
  digits = []
  while integer > 0
    integer, remainder = integer.divmod(10) # Reassign integer to the quotient of the division on same line
    digits.unshift(remainder)
  end
  
  digits
end

# # LS Solution, "Brute Force"
#   # same as mine, except using loop instead of a while loop
def digit_list(number)
  digits = []
  loop do
    number, remainder = number.divmod(10)
    digits.unshift(remainder)
    break if number == 0
  end
  digits
end

# Idiomatic Ruby
def digit_list(number)
  number.digits.reverse
end

# or, LS:
def digit_list(number)
  number.to_s.chars.map(&:to_i)
end

# (&:to_i) is shorthand for something.map { |char| char.to_i }


puts digit_list(12345) == [1, 2, 3, 4, 5]     # => true
puts digit_list(7) == [7]                     # => true
puts digit_list(375290) == [3, 7, 5, 2, 9, 0] # => true
puts digit_list(444) == [4, 4, 4]             # => true