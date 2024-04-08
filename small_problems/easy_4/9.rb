=begin
# Convert a Number to a String!

# PROBLEM
Write a method that takes a positive integer or zero, and converts it to a string representation.

Input: positive integer (>= 0)
Output: string representation of that integer

Rules:
  - Do not use any standard Ruby coversion methods (Integer#to_s, String(), Kernel#format)
  - Input will be a positive integer or zero

# EXAMPLES
integer_to_string(4321) == '4321'
 4 3 2 1 - concatenate - 4321

integer_to_string(0) == '0'
integer_to_string(5000) == '5000'

# DATA STRUCTURE
start: integer
middle: array to hold all integers + convert them
end: string

# ALGORITHM
Given an integer greater than or equal to zero,
- create a hash "DIGITS" with integer keys / string equivalent values
- create var "digits_arr" and assign to empty array
- Split the integer into its digits, add to "digits_arr"
- Iterate through digits_arr, convert each number to a string
  - look up current digit as key in DIGITS hash
  - transform with string value
- join "digits_arr" into a string

** Split the integer into its digits, add to "digits_arr"** 
Given integer,
- Manual Option -
- create working_int, assign to integer
- create array "result" assign to empty string
- start a loop
  - divide working_int by 10 with remainder
  - reassign working_int to the quotient
  - look up the remainder as key in DIGITS
    - add the value to "result" string
  - break the loop when working_int == 0 (or <= 0)
- join "digits" array into a string, and reverse the characters
- return that string

=end
DIGITS = {
  0 => '0', 1 => '1', 2 => '2',
  3 => '3', 4 => '4', 5 => '5',
  6 => '6', 7 => '7', 8 => '8',
  9 => '9'
}

# def integer_to_string(integer)
#   digits_arr = integer.digits.reverse
#   digits_arr.map { |digit| DIGITS[digit] }.join
# end

# Manual Option - dividing by 10 to get quotient and remainder
def integer_to_string(integer)
  working_int = integer
  result = ''
  loop do
    arr = working_int.divmod(10)
    working_int = arr[0]
    result.prepend(DIGITS[arr[1]])
    break if working_int == 0
  end
  result
end

p integer_to_string(4321) == '4321'
p integer_to_string(0) == '0'
p integer_to_string(5000) == '5000'

# TIME: 7:33

# FURTHER EXPLORATION
  # String#prepend does not end in !, but is mutating.
  # It's common in Ruby for mutating methods that do not have a correspondng non-mutating form to not have the ! suffix. Methods that have both forms distinguish (chomp vs chomp!)
  
  # Are there any mutating String methods that do not end in ! ?
    # String#[]=
    # String#concat
    # String#insert
    # String#prepend
    # String#replace
    

  # Are there any mutating Array methods that do not end in ! ?


  # Are there any mutating Hash methods that do not end in ! ?
    # Hash#keep_if