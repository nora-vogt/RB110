require 'pry'
=begin
Clean up the words

PROBLEM
Input:
  - string (containing some words, some non-alpabetic chars)
Output:
  - string (non-alphabetic characters replaced by spaces)

Rules:
- alphabetic characters are a-z, all lowercase
- Replace non-alphabetic characters with spaces
- if more than 1 non-alphabetic characters appear in a row, replace with only 1 space
  - ex: '---what' => ' what' (3 non-alpha -> 1 space)
- never have 2 consecutive spaces in answer
- regular punctutation marks should be removed too (like apostrophes, question marks)
- original spaces in the string should be preserved, but do not duplicate whitespaces if next to a non-alpha char or another space

Qs:
- should the method return the original string or a new string?

EXAMPLES
cleanup("---what's my +*& line?") == ' what s my line '

"   what s my     line "
new = ' ' (first char of string)
"  what s my     line "
current = ' '

compare new[0] to current[0]

if new[0] is a space and current[0] is a space
  do nothing
otherwise
    add current[0] to new


--- -> replace with spacespace
what -> stays
' -> replace with space
s -> stays
(space) -> stays
my -> stays
(space) -> stays
+*& -> already preceeded by space, so removed
(space) -> already preceeded by space, removed
line -> stays
? -> replace with space

" what s my line "

could replace all non-alpha chars with spaces
then normalize number of spaces?

need to check character before and character after

DATA STRUCTURE
start: string
middle: array
end: string

ALGORITHM
- Given a string,
- create "result", to reference empty string
- create "chars" assign to empty array
- replace all non-alphabetic characters with spaces
- break the string into an array of all characters, assign to "chars"
- remove first char from array and add to "result"
- loop through the array of remaining characters, with index
  - check if last char of result is a space, and if current char is a space
    (checking if the char at the last index position of result is the same as current char)
    - if not, add the current char to "result"
    - if yes, do nothing
- return result
=end

# My Solution - actually combines elements of both LS solutions
def cleanup(string)
  result = ''
  chars = string.gsub(/[^a-z]/, ' ').split('')
  result << chars.shift
  chars.each_with_index do |char, index|
    result << char unless result[-1] == ' ' && char == ' '
  end

  result
end

# REFACTOR
def cleanup(string)
  string.gsub(/[^a-z]+/, ' ')
end

# / / - denotes the RegEx expression
# [ ] - a set of characters
# ^ - not
# a-z - characters a-z
# [^a-z] - match any character that is not included in a-z
# Adding the + to the end of the RegEx means "match 1 or more of the proceeding token". This means that one or multiple instances of a non-alphabetic character will be replaced by a single space. 

# LS Solution - try without gsub
ALPHABET = ('a'..'z').to_a

def cleanup(string)
  result = []
  string.chars.each do |char|
    if ALPHABET.include?(char)
      result << char
    else
      result << ' ' unless result.last == ' '
    end
  end
  result.join('')
end

# It looked weird to me at first to use an `unless` modifier within the `else` branch code. But it is actually okay if the `else` branch returns `nil` when a space is not added, because the return value of the `if` statement isn't used for anything in this code.

# LS Solution 2:
# String#gsub + String#Squeeze
# String#squeeze - squeeze(*selectors) - returns a copy of self with the characters specified by selectors "squeezed". "Squeezed" means that when the specified selector(s) appear multiple times consecutively, they are "squeezed" down to just a single character, rather than repeats.

def cleanup(string)
  string.gsub(/[^a-z]/, ' ').squeeze(' ')
end

p cleanup("---what's my +*& line?") == ' what s my line '