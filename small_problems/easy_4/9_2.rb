=begin
Convert a Number to a String!

Write a method that takes a positive integer or zero, and converts it to a string representation.

Input:
- integer (>= 0)
Output: 
- string representation

- inputs will be valid 
- do not use any Ruby conversion methods

EXAMPLES
integer_to_string(4321) == '4321'
integer_to_string(0) == '0'
integer_to_string(5000) == '5000'

4321
need to get 4, 3, 2, 1 into an array

4321 / 10 => 432, remainder 1

string = ''
"1"

divmod
4321.divmod(10) => [432, 1]
look up second number in DIGITS, add that value to start of new string
repeat
432.divmod(10) => [43, 2]
add second number to start of new string, repeat

ALGORITHM:
Given an integer, 
- create "DIGITS" - to reference a hash with integer/string equivalent key value pairs for 0-9
- create "result", assign to an empty string
- create "total", assign to the given integer
- start a loop
  - create variables "quotient" and "remainder" to assign to integers
  - divide "total" by 10, get the quotient and the remainder
  - look up the remainder as a key in DIGITS
    - add the returned value to the beginning of "result" string
  - reassign "total" to the quotient
- end loop when "total" is equal to 0
- return "string"
=end

DIGITS = { 0 => '0', 1 => '1', 2 => '2',
           3 => '3', 4 => '4', 5 => '5', 
           6 => '6', 7 => '7', 8 => '8', 
           9 => 9
}

def integer_to_string(integer)
  result = ''
  total = integer
  loop do
    quotient, remainder = total.divmod(10)
    result.prepend(DIGITS[remainder])
    total = quotient
    break if total == 0
  end
  result
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'

# TIME: 10:00