# Write a method that takes two strings as arguments, determines the longest of the two strings, and then returns the result of concatenating the shorter string, the longer string, and the shorter string once again. You may assume that the strings are of different lengths.

=begin
P  (Understand the Problem) ++++++++++++++++++++++++++++++++++++++++++
  Inputs:
    - Two strings (one shorter, one longer)

  Outputs: 
    - One string (result of concatenating: short + long + short)

  Explicit Rules:
    - Strings are different lengths 
    - Returned string should concatenate short string + longer string + shorter string again

  Implicit Rules:
    - Output is a new string, rather than mutating an input string
    - If one input string is empty, output will have same value as non-empty string

  Questions:
    - How to treat a string made of only whitespace? 
    - Or with leading and trailing whitespaces?

  Mental Model:
   Compare two given strings to see which is longer. Return a new string that concatenates the short string + longer string + shorter string again.
 
E (Examples & Test Cases) ++++++++++++++++++++++++++++++++++++++++++++

short_long_short('abc', 'defgh') == "abcdefghabc"
short_long_short('abcde', 'fgh') == "fghabcdefgh"
short_long_short('', 'xyz') == "xyz"

D (Data Structure) +++++++++++++++++++++++++++++++++++++++++++++++++++
  Strings

A (Algorithm) ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  1. Compare the length of the first input string with second input string
    a. Assign shorter_string to string with fewer characters
    b. Assign longer_string to string with more characters
  2. Concatenate shorter_string + longer_string + shorter_string
  3. Return the new string

C (Code with Intent)  ++++++++++++++++++++++++++++++++++++++++++++++++
=end


def short_long_short(first_string, second_string)
  if first_string.size > second_string.size
    second_string + first_string + second_string
  else
    first_string + second_string + first_string
  end
end

p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"