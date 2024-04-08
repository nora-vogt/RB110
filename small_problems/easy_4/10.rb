=begin
Convert a Signed Number to a String!

Write a method that takes an integer, and converts it to a string representation.

Input:
  - integer (positive or negative)
Output
  - String (with leading positive or negative sign)

Rules:
- Input string may or may not have a leading sign
- Positive input, with or without leading +, should return "+4321"
- Negative input -> output should lead with "-"
- 0 should not lead with a sign

Qs
- if a positive integer input is given without a sign, should it return a leading +? we are going with YES

EXAMPLES:
signed_integer_to_string(4321) == '+4321'
signed_integer_to_string(-123) == '-123'
signed_integer_to_string(0) == '0'

+4321
first char: +
string: "+4321"

-123
first char: -
string: -123

0
first char: 0
string: "0"

leading - won't work with divmod
- check if integer == absolute value of integer (int as a positive number)

DATA STRUCTURE:
start: integer
middle: string
end: string

ALGORITHM:
Given an "integer", 
Given the integer_to_string method, 
- create var "sign" to reference an empty string
- Check if the integer is 0, if so return "0" (guard clause)
- check if integer is equal to the absolute value of the integer
  - if yes: add + to "sign"
  - if no: add "-" to sign, and reassign integer to integer.abs
- create var "result", assign to result of invoking integer_to_string(integer)
- prepend "sign" to "result"
- return "result"
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

# def signed_integer_to_string(integer)
#   return "0" if integer == 0
#   sign = ''
#   if integer == integer.abs
#     sign << '+'
#   else
#     sign << '-'
#     integer = integer.abs
#   end
#   result = integer_to_string(integer)
#   sign + result
# end


# TIME: 10:02

# LS Solution
# def signed_integer_to_string(number)
#   case number <=> 0 # spaceship operator*
#   when -1 then "-#{integer_to_string(-number)}" # -number arg -> -(-123) -> 1 converts to positive
#   when +1 then "+#{integer_to_string(number)}"
#   else         integer_to_string(number)
#   end
# end

# <=>
  # returns +1 if number > 0
  # returns -1 if number < 0
  # returns 0 if number == 0

# Further Exploration
  # Refactor our solution to reduce the 3 integer_to_string calls to just one.

def signed_integer_to_string(number)
  sign = if number > 0
          '+'
         elsif number < 0 
           '-'
         else
            ''
      end

  sign + integer_to_string(number.abs)
end

# From other solutions
# what does this notation mean
# sign = ['', '+', '-'][integer <=> 0]
#[][]

p signed_integer_to_string(4321) == '+4321'
p signed_integer_to_string(-123) == '-123'
p signed_integer_to_string(0) == '0'