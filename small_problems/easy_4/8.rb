# Convert a String to a Signed Number!

=begin
# PROBLEM
Write a method that takes a String of digits, and returns the appropriate number as an integer with corresponding sign if negative.

Input:
  - string (of digits), with or without a leading sign
Output:
  - positive or negative integer (with - sign)

Rules:
   - If first char of string is +, return a positive number
   - If first char of string is -, return a negative number
   - If no sign given (first char is a number), return a positive number
   - String will always contain a valid number
   - Do not use any built-in Ruby conversion methods like String#to_i or Integer()
   - May use string_to_integer from previous assignment

# EXAMPLES
string_to_signed_integer('4321') == 4321
string_to_signed_integer('-570') == -570
string_to_signed_integer('+100') == 100

# DATA STRUCTURE
start: string, with or without leading sign
middle: array of string number converted to integers
end: integer

# ALGORITHM
Given a string of digits, "string"

- Create "DIGITS" hash, keys are number strings, values are corresponding integer (0-9)
- create "digits_arr" and assign to an empty array
- create var "positive" and assign to true
- split "string" into its characters, assign to "digits_arr"
- check char at index 0 of "digits_arr"
  - if '-', then assign "positive" to false
    - remove char at index 0
  - if '+', remove char at index 0
  - otherwise, do nothing
- convert chars in "digits_arr" to integers
    - iterate through "digits_arr"
    - use current_num as key in DIGITS has to retrieve integer value
    - return a new array of these integer values and assign to "digits_arr"
- create variable "exponent" and assign to digits_arr.length - 1
- create variable "sum" and assign to 0
- convert integers in digits_arr into a single integer
    - iterate through "digits_arr"
      - reassign sum to the result of current_num * 10**exponent
      - decrement exponent by 1
- check value of "positive"
    - if true, return sum
    - if false, return sum as a negative number
=end

DIGITS = {
  '0' => 0, '1' => 1, '2' => 2,
  '3' => 3, '4' => 4, '5' => 5,
  '6' => 6, '7' => 7, '8' => 8,
  '9' => 9
}

# REFACTOR, USING string_to_integer
  # break the string into an array of characters
  # check the first character
    # if '-', call -string_to_integer(string[1..-1]) (adds - to return value)
    # if '+', call string_to_integer(string[1..-1])
    # otherwise, call string_to_integer(string)
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

# def string_to_signed_integer(string)
#   case string[0]
#   when '-' then -string_to_integer(string[1..-1])
#   when '+' then string_to_integer(string[1..-1])
#   else          string_to_integer(string)
#   end
# end

# FURTHER EXPLORATION, refactor to only call string[1..-1] and string_to_integer twice
def string_to_signed_integer(string)
  result = string_to_integer(string.delete('^0-9')) # delete everything that isn't a number
  string[0] == '-' ? -result : result
end



# def string_to_signed_integer(string)
#   integer = case string[0]
#            when '-', '+' then string_to_integer(string[1..-1])
#            else          string_to_integer(string)
#            end

#   string[0] == '-' ? -integer : integer
# end

# FIRST TRY, REDOING EVERYTHING
# def string_to_signed_integer(string)
#   digits_arr = string.split('')
#   positive = true

#   if digits_arr[0] == '-'
#     positive = false
#     digits_arr.shift
#   elsif digits_arr[0] == '+'
#     digits_arr.shift
#   end

#   digits_arr.map! { |char| DIGITS[char] }
  
#   exponent = digits_arr.length - 1
#   sum = 0

#   digits_arr.each do |digit|
#     sum += digit * 10**exponent
#     exponent -= 1
#   end

#   positive ? sum : -sum
# end

p string_to_signed_integer('4321') == 4321
p string_to_signed_integer('-570') == -570
p string_to_signed_integer('+100') == 100