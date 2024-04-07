=begin
Letter Swap

PROBLEM
Given a string of words separated by spaces, write a method that returns a string in which the first and last letters of every word are swapped.

Input:
- String
Output
- String (letters swapped)

Rules:
- Every word contains at least one letter
- The given string will always contain at least one word (no empty strings given)
- Each string will only contain words and spaces
- A "word" is denoted by a preceeding or superceeding whitespace
- Swap the first and last letters of each word
- Case is preserved when swapping letters (Oh -> hO)
- The string returned should have the same number of words as given string

Qs:
- Should this method return a new String, or mutate given string? 
  - we will return a new string

EXAMPLES
swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
Oh what a wonderful day it is

Oh
index 0: O
index -1: h

what
0: w
-1: t

a
0: a
-1: a
...

swap('Abcde') == 'ebcdA'
0: A
-1: e
=> ebcdA

swap('a') == 'a'

DATA STRUCTURE
start: string
middle: array of strings (first_char, last_char)
end: new string

ALGORITHM
Given a string of words and whitespaces,
- initialize var "first_char", assign to empty string
- initialize var "last_char", assign to empty string
- initialize "result" to an empty string
- Split the string into an array of words, assign to "result"
- itearte through the array of words
  - for each word: 
    - assign first_char to char at index 0
    - assign last char to char at index -1
    - replace the char at index 0 with last_char
    - replace the char at index -1 with first_char
- join the array of words back into a string
- return the string
=end

def swap(string)
  result = ''
  first_char = ''
  last_char = ''

  result = string.split(' ').each do |word|
    first_char = word[0]
    last_char = word[-1]
    word[0] = last_char
    word[-1] = first_char
  end

  result.join(' ')
end
TIME: 10:55

# REFACTOR WITH MULTIPLE ASSIGNMENT
def swap(string)
  result = string.split(' ').each do |word|
    word[0], word[-1] = word[-1], word[0]
  end

  result.join(' ')
end

# p swap('Oh what a wonderful day it is') == 'hO thaw a londerfuw yad ti si'
# p swap('Abcde') == 'ebcdA'
# p swap('a') == 'a'

# NOTES - multiple assignment
# a, b = b, a - pattern to swap values of two variables
# Ruby creates a temporary array with assigned values on right [b, a]
  # then assigns each element in order to left side
    # a on left is assigned to b on right
    # b on left is assigned to a on right

# LS Solution - Original
def swap_first_last_characters(word)
  word[0], word[-1] = word[-1], word[0]
  word
end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word)
  end
  result.join(' ')
end

# Further Exporation:
# Compare This implementation:
def swap_first_last_characters(a, b)
  a, b = b, a
end

def swap(words)
  result = words.split.map do |word|
    swap_first_last_characters(word[0], word[-1])
  end
  result.join(' ')
end


p swap('Oh what a wonderful day it is')# == 'hO thaw a londerfuw yad ti si'
# p swap('Abcde') == 'ebcdA'
# p swap('a') == 'a'

# In the original solution, the `swap_first_last_characters` method is invoked and passed the string referenced by `word` as an argument. Within the `swap..characters` method definition, that original string object is being mutated by `word[0], word[-1] = word[-1], word[0]`. This multiple assignment actually calls the `String#[]=` method, which is a destructive method that reassigns the character at the specified index, mutating the calling string. The original object, now mutated, is then returned by the `swap..characters` method.

# In the second implementation, instead of passing in `word` as an argument, the return value of `word[0]` and `word[1]` are passed in as arguments. This is String#[], element reference, which returns a new string object. 

# Now, within the `swap..characters` method, those two new strings now bound to `a` and `b` are simply reassigned to reference different String objects. There is no mutation, and this does not affect the value of `word`, as that object was never passed in as an argument. Additionally, `swap..characters` now returns a 2-element array, containing the assigned objects, which produces unexpected output when this return value is used for transformation within the block passed to `#map`.