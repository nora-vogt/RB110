=begin
In the previous two exercises, you developed methods that convert simple numeric strings to signed Integers. In this exercise and the next, you're going to reverse those methods.

Write a method that takes a positive integer or zero, and converts it to a string representation.

You may not use any of the standard conversion methods available in Ruby, such as Integer#to_s, String(), Kernel#format, etc. Your method should do this the old-fashioned way and construct the string by analyzing and manipulating the number.

# PROBLEM
Input: an Integer (>= 0)
Output: string, representation of that integer

Explicit Rules:
  - Input will be a positive integer or zero
  - Do not use any Ruby standard conversion methods
Implicit Rules:

Mental Model:
Given an integer greater than or equal to zero, return the string representation of that integer. 

# EXAMPLES
integer_to_string(4321) == '4321'
integer_to_string(0) == '0'
integer_to_string(5000) == '5000'

# DATA STRUCTURE
start: integer
middle: 
  - Hash, to store integer/string pairs
  - Array, to break up and store each number of the digit
end: string

# ALGORTHM
Given an integer greater than or equal to zero:

1. Create a variable "INTEGERS_AND_STRINGS" to reference key/value pairs of integers and their string representations
2. Create a variable "digits" to reference an empty array
3. Create a variable "result" to reference an empty string  # didn't need due to implementation
4. Split the given integer into its component numbers and store in "digits"
5. Iterate through "digits" and convert each number to a string, then add to "result"
6. Return "result"

# CODE
=end

INTEGERS_AND_STRINGS = {
  0 => '0', 1 => '1', 2 => '2',
  3 => '3', 4 => '4', 5 => '5',
  6 => '6', 7 => '7', 8 => '8',
  9 => '9'
}

# First attempt
# def integer_to_string(integer)
#   digits = integer.digits.reverse
#   digits.map {|digit| INTEGERS_AND_STRINGS[digit]}.join
# end

# Refactored
def integer_to_string(integer)
  integer.digits.reverse.map {|digit| INTEGERS_AND_STRINGS[digit]}.join
end

# Further Exploration
# How many mutating String methods can you find that do not end with a !
  # String#insert
  # String#<<
  # String#replace
  # String#setbyte
  # String#clear
  # String#[]=
  # String#concat
  # String#prepend

# Array mutating methods that don't end with !
  # Array#push
  # Array#<<
  # Array#unshift
  # Array#insert
  # Array#pop
  # Array#shift
  # Array#delete_at
  # Array#delete
  # Array#delete_if
  # Array#keep_if
  # Array#fill
  # 


# Can you find any that end with a !, but don't have a non-mutating form? 
  # String Class - can't find any

  # Array Class
    # Array#sort_by! (vs. Enumerable#sort_by)


  # Hash Class



p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'