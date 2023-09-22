=begin
Write a method that determines and returns the ASCII string value of a string that is passed in as an argument. The ASCII string value is the sum of the ASCII values of every character in the string. (You may use String#ord to determine the ASCII value of a character.)

# PROBLEM
input: a string
output: an Integer, representing the ASCII string value

Explicit rules:
  - The ASCII string value is the sum of the individual ASCII values of every character in the string.
  - String#ord returns the ASCII value of a character
Implicit Rules:
  - an empty string should return 0
  - Strings may have upper or lowercase letters, spaces, or be empty


# EXAMPLES
ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0

# DATA STRUCTURE
  start: string
  middle: array of string characters to iterate through
  end: sum
# ALGORITHM
  Given a string,

  0. create a variable "value" to hold total ASCII value
  1. Iterate through the string, character by character
    a. find the ASCII value of that character
    b. add the value to "value"
    c. repeat until the end of the string

  2. return "value"

# CODE
=end

def ascii_value(string)
  value = 0
  string.chars.each {|char| value += char.ord} # could also use String#each_char
  value
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0

# Further Exploration
# What Integer method makes the following true:
# char.ord.mystery == char
# Integer#chr

char = 'a'
p char.ord.chr == char

# but if we try this with a longer string, it doesn't work. That's because String#ord returns the integer ordinal for only the first character in the string.
str = 'abc'
str.ord # => 97, the ordinal value of 'a'
str.ord.chr # => "a"