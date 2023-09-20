require 'pry'
=begin
Write a method that takes a String of digits, and returns the appropriate number as an integer. The String may have a leading + or - sign; if the first character is a +, your method should return a positive number; if it is a -, your method should return a negative number. If no sign is given, you should return a positive number.

You may assume the string will always contain a valid number.

You may not use any of the standard conversion methods available in Ruby, such as String#to_i, Integer(), etc. You may, however, use the string_to_integer method from the previous lesson.

# PROBLEM
Input: a string (of digits)
Output: an integer

Explicit Rules:
  - The string may have a leading + or - sign
  - If first character of string is +, return a positive number
  - If first character of string is -, return a negative number
  - If no sign given, assume a positive number
  - Input string will always contain a valid number
  - Do not use any standard Ruby conversion methods
  - OK to use string_to_integer method from previous question

Implicit Rules:
  - First character of string may be a sign or a number

Mental Model:
  The input will be a string representing a number. Determine whether it is a positive or negative number. Positive numbers will have either no leading sign, or a + sign. Negative numbers must have a leading - sign. Once you've determined whether the number is positive or negative, convert it to its corresponding integer.

# EXAMPLES
string_to_signed_integer('4321') == 4321
string_to_signed_integer('-570') == -570
string_to_signed_integer('+100') == 100

# DATA STRUCTURES
beginning: String
middle: 
- Hash for digit key/value pairs (string => integer
- Array to store converted numbers
- Some marker for positive or negative number - a Boolean maybe?
  (if positive => return a positive number; if negative => return a negative number)

# ALGORITHM
Given a string,
0. Create a variable "DIGITS" to hold the string numbers and their corresponding integer values

0. Create a variable "digits" to hold all the string digits converted to integers

0. Create a variable "value" to hold the final converted integer value

1. Create a variable "positive" - assign to true as default

2. Check the first character of the string. 
  a. If it is a - sign
    1. reassign "positive" to false
    2. remove the first character from the string
  a. If it is anything else, do nothing

3. Iterate through the given string, character by character
    a. For each character, retrieve the corresponding integer value in the DIGITS hash
    b. Add the integer value to the "digits" array

4. Convert the "digits" array to an integer
  a. Iterate through each number in "digits". For each number:
    1. Reassign "value" to: 10 * value + current digit
    2. Repeat until iterated through all digits

5. Check the value of "positive"
    a. if true, return "value"
    b. if false, return value * -1

# CODE
=end

DIGITS = {
  '0' => 0, '1' => 1, '2' => 2,
  '3' => 3, '4' => 4, '5' => 5,
  '6' => 6, '7' => 7, '8' => 8,
  '9' => 9
}

def string_to_integer(string)
  digits = string.chars.map {|char| DIGITS[char]}
  digits.inject {|sum, digit| 10 * sum + digit}
end

# ORIGINAL SOLUTION
# def string_to_signed_integer(string)
#   if string[0] == '-'
#     value = string_to_integer(string.delete_prefix('-'))
#     value * -1
#   elsif string[0] == '+'
#     string_to_integer(string.delete_prefix('+'))
#   else
#     string_to_integer(string)
#   end
# end

# REFACTORED - CASE STATEMENT
# def string_to_signed_integer(string)
#   case string[0]
#   when '-' then string_to_integer(string.delete_prefix('-')) * -1
#   when '+' then string_to_integer(string.delete_prefix('+'))
#   else          string_to_integer(string)
#   end
# end

# REFACTORED - LS SOLUTION
# def string_to_signed_integer(string)
#   case string[0]
#   when '-' then -string_to_integer(string[1..-1]) # can just add a - to return value of method invocation
#   when '+' then string_to_integer(string[1..-1])
#   else          string_to_integer(string)
#   end
# end

# FURTHER EXPLORATION - REFACTOR
# In our solution, we call string[1..-1] twice, and call string_to_integer three times. This is somewhat repetitive. Refactor our solution so it only makes these two calls once each.

def string_to_signed_integer(string)
  first_char = string[0]
  if ['-', '+'].include?(first_char)
    string = string[1..-1]
  end

  value = string_to_integer(string)
  first_char == '-' ? -value : value
end

p string_to_signed_integer('4321') == 4321
p string_to_signed_integer('-570') == -570
p string_to_signed_integer('+100') == 100