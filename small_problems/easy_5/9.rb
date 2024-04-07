=begin
ddaaiillyy ddoouubbllee

Write a method that takes a string, and returns a new string with all characters from the original string with CONSECUTIVE duplicates removed.

Input:
- string

Output:
- new string

Rules:
- Do not use String#squeeze! or String#squeeze
- Given an empty string should return an empty string
- strings may contain numbers, letters or spaces
- return value should preserve single whitespace
- only remove consecutive duplicate characters


Qs:
- should mixed-case letter duplicates be removed? (ex: Aa), or does case count as different characters

EXAMPLES:
crunch('ddaaiillyy ddoouubbllee') == 'daily double'
crunch('4444abcabccba') == '4abcabcba'
crunch('ggggggggggggggg') == 'g'
crunch('a') == 'a'
crunch('') == ''

ddaaiillyy ddoouubbllee
clean = 'd'
daaiillyy ddoouubbllee - iterate
index: 0
char: d

clean[cleansize - index] == char - YES

index: 1
char: a
clean[clean.size - index] => clean[0]== char - NO

clean = 'da'
index = 2
char: a
clean[clean.size - 1] => clean[1] == char - YES

this is comparing last char in clean string to current char 


DATA STRUCTURE:
start: string
middle: array of characters
middle: array of characters with duplicates removed
end: string

ALGORITHM:
Given a string, "string"
- create variable "clean_string" and assign to first char of "string"
- split "string" into component characters, iterate through characters [1..-1] (skip the first characters)
  - compare current char to last char in clean_string
    - if values are equal, do nothing
    - if values are not equal, add current char to clean_string
- return clean_string
=end

# def crunch(string)
#   clean_string = ''
#   string.split('').each do |char|
#     clean_string << char unless char == clean_string[-1]
#   end
#   clean_string
# end

# p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
# p crunch('4444abcabccba') == '4abcabcba'
# p crunch('ggggggggggggggg') == 'g'
# p crunch('a') == 'a'
# p crunch('') == ''

# LS Solution - use a loop
# compare current char to next char in string
  # if they are the same, move on
  # if they are different, add current char to clean_string
# def crunch(string)
#   clean_string = ''
#   index = 0

#   while index < string.length # until index == string.length
#     p index
#     current_char = string[index]
#     clean_string << string[index] unless string[index] == string[index + 1]
#     index += 1
#   end
#   p clean_string
# end

# p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
# p crunch('4444abcabccba') == '4abcabcba'
# p crunch('ggggggggggggggg') == 'g'
# p crunch('a') == 'a'
# p crunch('') == ''

# Further Exploration - RegEx
# () - capture group, groups characters together to extract or backreference. they are numbered sequentially. reference them later by \number (backslash group number)
# . - any character
# (.) - a capture group of any one character
# \1 - matches the first capture group
# + - match 1 or more of the preceeding token
# overall: match any consecutive duplicate characters
# the substitution is: \1 - the character indicated by capture group 1

def crunch(string)
  string.gsub(/(.)\1+/, '\1')
end

p crunch('ddaaiillyy ddoouubbllee') == 'daily double'
p crunch('4444abcabccba') == '4abcabcba'
p crunch('ggggggggggggggg') == 'g'
p crunch('a') == 'a'
p crunch('') == ''