=begin
In the previous exercise, you developed a method that converts non-negative numbers to strings. In this exercise, you're going to extend that method by adding the ability to represent negative numbers as well.

Write a method that takes an integer, and converts it to a string representation.

You may not use any of the standard conversion methods available in Ruby, such as Integer#to_s, String(), Kernel#format, etc. You may, however, use integer_to_string from the previous exercise.

# PROBLEM
Input: integer
Output: a String

Explicit Rules:
Implicit Rules:
  - given 0, should return '0'
  - given a positive integer, should return a string leading with '+123'
  - given a negative integer, should return a string leading with '-123'

# EXAMPLES
signed_integer_to_string(4321) == '+4321'
signed_integer_to_string(-123) == '-123'
signed_integer_to_string(0) == '0'

# DATA STRUCTURES
start: integer
middle: array
end: string

# ALGORITHM
Given an integer,

0. create a variable "negative", to represent whether the given integer is positive or negative

1. Check if the integer is less than 1
  a. If yes, make the integer into a positive number
  b. set the "negative" to true
  c. If no, do nothing

2. Invoke the integer_to_string method from previous exercise

3. Check if the string is equal to "0"
    a. if yes, return the string
    b. if no, continue on

3. Check the value of "negative"
    a. If "negative" is equal to true, add a '-' to the beginning of the string and return the string
    b. If "negative" is false, add a "+" to the beginning of the string and return the string

# CODE

=end

INTEGERS_AND_STRINGS = {
  0 => '0', 1 => '1', 2 => '2',
  3 => '3', 4 => '4', 5 => '5',
  6 => '6', 7 => '7', 8 => '8',
  9 => '9'
}

def integer_to_string(integer)
  integer.digits.reverse.map {|digit| INTEGERS_AND_STRINGS[digit]}.join
end

def signed_integer_to_string(integer)
  return "0" if integer == 0
  string = integer_to_string(integer.abs)

  integer < 0 ? string.prepend('-') : string.prepend('+')
end


p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'