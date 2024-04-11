=begin
Delete Vowels

Input:
- array of strings

Output:
- array of strings with all vowels removed
- preserve case of strings

Rules:
- vowels are a e i o u
- remove both upper and lower case vowels
- if a string contains ONLY vowels, returned string should be empty
- returned array should have same number of strings as given array
- y is not considered a vowel for this example

Qs:
- Should this method return a new array, or the same given array?

# EXAMPLES
%w(green YELLOW black white)) == %w(grn YLLW blck wht)
green -> grn
YELLOW -> YLLW

# DATA STRUCTURE
start: array
middle: array
end: array

# ALGORITHM
Given an array of strings, "string_array"
- iterate through string_array
  - delete all vowels from the current string
  - return a new array containing transformed strings
=end

def remove_vowels(string_array)
  string_array.map { |string| string.delete('aeiouAEIOU')}
end

#another solution - String#gsub
def remove_vowels(string_array)
  string_array.map { |string| string.gsub(/[aeiouAEIOU]/, '')}
end

# iterate through array of chars to use #delete_if
def remove_vowels(string_array)
  vowels = %w(a e i o u A E I O U)
  string_array.map do |string|
    string.chars.delete_if { |char| vowels.include?(char)}.join
  end
end

p remove_vowels(%w(abcdefghijklmnopqrstuvwxyz)) == %w(bcdfghjklmnpqrstvwxyz)
p remove_vowels(%w(green YELLOW black white)) == %w(grn YLLW blck wht)
p remove_vowels(%w(ABC AEIOU XYZ)) == ['BC', '', 'XYZ']

# TIME: 5 mins