=begin
ASCII String Value

Write a method that takes a string and returns the ASCII value of that string. 

Input: string
Output: Integer (ASCII value)

Rules:
- The ASCII string value is the sum of the ASCII values of every character in the string
- Each character has an ASCII value
- An empty string argument should return an empty string
- Given string may mix upper and lower case
- May usse String#ord to determine ASCII value of char
- Whitespaces do have a ASCII value

String#Ord - Returns teh integer ordinal of the first character of self
  - on ASCII tables, the string seems to convert to a decimal number?

Qs:
- Does whitespace have a ASCII value / count as a character?

EXAMPLES:
ascii_value('Four score') == 984
ascii_value('Launch School') == 1251
ascii_value('a') == 97
ascii_value('') == 0

Four score
70 + 111 + 117 + 114 + 32 + 115 + 99 + 111 + 114 + 101
Four + space + score

# DATA STRUCTURE
start: string
middle: array of characters
middle: integer
end: integer

# ALGORITHM
Given a string, "string"
- initialize variable "value" and assign to 0
- split the string into an array of characters, preserving whitespaces
- iterate through the array of charactes
  - find the ASCII value of the current character
  - add the value to "value"
- return "value"
=end

def ascii_value(string)
  value = 0
  string.chars.each { |char| value += char.ord }
  value
end

# Refactor - Try using Enumerable#Inject
def ascii_value(string)
  string.chars.inject(0) { |sum, char| sum + char.ord }
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0

# TIME: 10:00

# Further Exploration:
# char.ord.mystery == char
# Need to convert an ordinal number to a string
# Integer#chr - returns a 1-character string containing the character represented by the value of self, according to the given encoding
char = "A"
p char.ord.chr == char


