
require 'pry'
=begin
Write a method that takes a String of digits, and returns the appropriate number as an integer. You may not use String#to_i or Integer()

# PROBLEM
  Input: a String
  Output: an Integer (representation of the input string)

  Explicit Rules:
    - Input will not have leading + or - signs
    - Input will not be invalid (only numeric characters will be given)
    - Do not use any standard Ruby conversion method (ex, String#to_i or Integer())
  Implicit Rules:
  - 

Mental Model:
  Given a string consisting of numeric characters, convert those characters to their corresponding Integer. Return that Integer. Do not use any built-in Ruby conversion methods. 

# EXAMPLES

  string_to_integer('4321') == 4321
  string_to_integer('570') == 570

  {'0' => 0, '1' => 1, '2' => 2 ...}

  sum = 0
  [4, 3, 2, 1]
  10 * sum + next_digit
  10 * 0 + 4 => 4
  10 * 4 + 3 => 43
  10 * 43 + 2 => 432
  10 * 432 + 1 => 4321


# DATA STRUCTURE
Start: String
Middle: 
  - use a Hash - string and integer key/value pairs for comparison
  - an Array - to store the integer representations of string characters
End: Integer

# ALGORITHM
1. Create a hash, "comparison_strings" to store key/value pairs representing a string numeric character and its corresponding integer.

2. Create an Array, "numbers" to hold the integer representations of string characters

2. Iterate through all characters in the input string. 
  a. Check if the current character is a key in the comparison_strings hash.
    1. If yes, access the value associated with that key and add it to the "numbers" array
    2. if no, do nothing

3. Create a variable "value" to hold final integer, assign to 0

4. Iterate through "numbers"
    a. One each iteration, multiply 10 * converted_integer and add the current number (10 * value + current_num), and reassign value to the outcome

5. Return value

=end

def create_digits_hash
  hash = {}
  counter = 0
  ('0'..'9').each do |string|
    hash[string] = counter
    counter += 1
  end
  hash
end

# original
# def string_to_integer(string)
#   digits = create_digits_hash
#   numbers = []

#   string.chars.each { |char| numbers << digits[char]}

#   value = 0
#   numbers.each {|digit| value = 10 * value + digit}
#   value
# end

# using #inject
def string_to_integer(string)
  digits = create_digits_hash
  numbers = []

  string.chars.each { |char| numbers << digits[char]}

  numbers.inject {|sum, digit| 10 * sum + digit}
end

=begin
- Decimal - base 10
- Hexadecimal - base 16

'4D9f' == 19871
[4, 13, 9, 15]
reverse = [15, 9, 13, 4]

15 * 16**0 = 15
9 * 16**1 = 144
13 * 16**2 = 3328
4 * 16**3 = 16384

15 + 144 + 3328 + 16384 => 19871


=end

HEXADECIMAL_DIGITS = {
  '0' => 0, '1' => 1, '2' => 2,
  '3' => 3, '4' => 4, '5' => 5,
  '6' => 6, '7' => 7, '8' => 8,
  '9' => 9, 'A' => 10, 'B' => 11,
  'C' => 12, 'D' => 13, 'E' => 14,
  'F' => 15
}

def hexadecimal_to_integer(string)
  digits = string.upcase.chars.map {|digit| HEXADECIMAL_DIGITS[digit]}
  
  exponent = 0
  value = 0
  digits.reverse.each do |digit|
    value += digit * 16**exponent
    exponent += 1
  end

  value
end


p string_to_integer('4321') == 4321
p string_to_integer('570') == 570
p hexadecimal_to_integer('4D9f') == 19871
p hexadecimal_to_integer('DF') == 223
p hexadecimal_to_integer('1') == 1
p hexadecimal_to_integer('2654') == 9812
