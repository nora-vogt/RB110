# Convert a String to a Number!
=begin
Write a method that takes a String of digits, and returns the appropriate number as an integer. You may not use any of the methods mentioned above.

Input:
  - String of digits
Output:
  - Integer version of string

Rules:
  - May not use String#to_i
  - May not use Integer constructor Integer()
  - May not ue any other built-in Ruby conversion method
  - Input will not have leading + or - signs
  - Strings will all contain numeric digits
  - Strings may be of any length

Q's
  - What should an empty string return?

EXAMPLES:
string_to_integer('4321') == 4321
string_to_integer('570') == 570

'4321'
[4, 3, 2, 1] - iterate
sum = 0
10 * sum + current_num
10 * 0 + 4 = 4; sum = 4
10 * 4 + 3 = 43; sum = 43
10 * 43 + 2 = 432; sum = 432
10 * 432 + 1 = 4321; sum = 4321

# What the above code is doing:
  - multiplying the current number by 10, and adding the next number
  - this takes us from 0 -> 4 -> 43 -> 432 -> 4321
  - so kind of like finding the power of ten, but starting with the digit in the thousands place and working backwards

# Another way, using Powers of 10
4000 = 4 * 10**3 (10 to the power of 3)
300 = 3 * 10**2 (10 to the power of 2)
20 = 2 * 10**1 (10 to the power of 1)
1 = 1 * 10**0 (10 to the power of 0, which evaluates to 1)
4000 + 300 + 20 + 1 = 4321

The powers we are using are array.length - 1
- Decrement the powers with each iteration

the power are is the number of zeroes essentially

DATA STRUCTURE:
start: string
middle: hash to hold string number / int pairs
middle: array of string numbers
middle: array of integers
end: integer

ALGORITHM:
Given a string of numbers, "string"
- create constant DIGITS to reference hash. keys are number strings, values are int equivalents
- create var "digits_arr" to reference an empty array
- create var "sum" and assign to 0
- break the string into an array of substrings ('4321' -> ['4', '3', '2', '1']), assign to "digits_arr"
- iterate through "numbers"
  - get the value associated with the current number key in DIGITS
  - add value to "digits_arr"
- iterate through "digits_arr"
  - reassign sum to the total of 10 * sum + current number
- return sum
=end

# DIGITS = {
#   '0' => 0, '1' => 1, '2' => 2,
#   '3' => 3, '4' => 4, '5' => 5,
#   '6' => 6, '7' => 7, '8' => 8,
#   '9' => 9
# }

# def string_to_integer(string)
#   digits_arr = string.split('').map { |str| DIGITS[str] }
#   sum = 0
#   digits_arr.each { |num| sum = 10 * sum + num }
#   sum
# end

# p string_to_integer('4321') == 4321
# p string_to_integer('570') == 570

# Further Exploration
# Write a hexadecimal_to_integer method that converts a string representing a hexadecimal number to its integer value.
=begin
  - hexadecimal number system is base 16
  - 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, A, B, C, D, E and F
    - A -> 0
    - B -> 11 ...

# Update our DIGITS hash to include key/value pairs for the hexadecimal numbers
- Break "string" into an array of characters, assign to "digits_arr"
- Iterate through "digits_arr", look up upcased current character as key in DIGITS hash
  - reassign "digits_arr" to an array of integers from DIGITS
- create variable "power", assign to digits_arr.length - 1
-create variable "sum", assign to 0
- iterate through digits_arr
  - multiply current number * 16 to the power of "power"
  - add number to "sum"
  - decement power by 1
- return "sum"

4D9f
4, 13, 9, 15

4 * 16**3 + 13 * 16**2 + 9 * 16**1 + 15 * 16**0

=end

# DIGITS = {
#   '0' => 0, '1' => 1, '2' => 2,
#   '3' => 3, '4' => 4, '5' => 5,
#   '6' => 6, '7' => 7, '8' => 8,
#   '9' => 9, 'A' => 10, 'B' => 11,
#   'C' => 12, 'D' => 13, 'E' => 14,
#   'F' => 15
# }

# def hexadecimal_to_integer(string)
#   digits_arr = string.split('').map { |char| DIGITS[char.upcase] }
#   sum = 0
#   power = digits_arr.length - 1
#   digits_arr.each do |digit|
#     sum += digit * 16**power
#     power -= 1
#   end
#   sum
# end

# p hexadecimal_to_integer('4D9f') == 19871
# p hexadecimal_to_integer('F0') == 240


# Trying again, for understanding
=begin
'4321'

sum = 0
exponent = array.length - 1
['4' '3' '2' '1'] iterate
  sum += current_num * 10**exponent
  exponent -= 1


# Another way, using Powers of 10
4000 = 4 * 10**3 (10 to the power of 3)
300 = 3 * 10**2 (10 to the power of 2)
20 = 2 * 10**1 (10 to the power of 1)
1 = 1 * 10**0 (10 to the power of 0, which evaluates to 1)
4000 + 300 + 20 + 1 = 4321

The powers we are using are array.length - 1
- Decrement the powers with each iteration

the power are is the number of zeroes essentially

# ALGORITHM
# Given a string of numbers, "string"
- Create DIGITS, to reference a hash where keys are number strings and values are the corresponding integer
- create var "sum" and assign to zero
- create var "digits_arr" and assign to "string" split into an array of characters
- transform "digits_arr" from an array of strings to an array of integers
  - iterate through digits_arr
  - look up the current number as  key in the DIGITS hash, return the integer value
- create var "exponent" and assign to digits_arr.length - 1
- iterate through digits_arr
  - for each iteration
  - multiply: current number * 10**exponent
  - reassign sum to the result of sum + above multiplication
  - decrement exponent by 1
- return sum
=end

DIGITS = {
  '0' => 0, '1' => 1, '2' => 2,
  '3' => 3, '4' => 4, '5' => 5,
  '6' => 6, '7' => 7, '8' => 8,
  '9' => 9
}

def string_to_integer(string)
  digits_arr = string.split('').map { |char| DIGITS[char] }
  sum = 0
  exponent = digits_arr.length - 1

  digits_arr.each do |digit|
    sum += digit * 10**exponent
    exponent -= 1
  end
  
  sum
end

p string_to_integer('4321') == 4321
p string_to_integer('570') == 570