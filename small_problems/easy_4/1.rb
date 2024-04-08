# Short Long Short

#### PROBLEM
# Write a method that takes two strings as arguments, determines the longest of the two strings, and then returns the result of concatenating the shorter string, the longer string, and the shorter string once again. You may assume that the strings are of different lengths.

# Inputs: two strings of different lengths
# Output: one string, concatenated short + long + short

# Explicit Rules:
  # determine which string is longer
  # concatenate shorter + longer + shorter string
  # strings are of differentn lengths

# Implicit Rules:
  # method returns a new string
  # if one string is empty, the result is just the second string one time ('', 'xyz' -> 'xyz')
  # I decided: two empty strings will return an empty string.

# Qs
  # How should two empty strings be handled?
  # will the inputs always be two strings? YES

#### EXAMPLE

# short_long_short('abc', 'defgh') == "abcdefghabc"
  # abc length = 3
  # defgh length = 5 *longest*

  # abc + defgh + abc = "abcdefgh"

# short_long_short('abcde', 'fgh') == "fghabcdefgh"
# short_long_short('', 'xyz') == "xyz"
  # '' = 0
  # xyz = 3 *longest*

  # '' + xyz + '' = "xyz"


#### DATA STRUCTURE
  # start: strings
  # middle strings
  # last: string


#### ALGORITHM
# Given two strings,
  # create variable "longest" to assign to string with longest length
  # create variable "shortest" to assign to strign with shortest length
  # determine which of two given strings is longest
    # get character count of each string
    # string with higher character count is longest
    # assign that string to "longest"
    # assign remaining string to "shortest"
  # concatenate shortest + longest + shortest and return result


# First PEDAC + solution: 9 mins
def short_long_short(first_str, second_str)
  longest, shortest = first_str.size > second_str.size ? [first_str, second_str] : 
                                                         [second_str, first_str]
  
  shortest + longest + shortest
end

# Refactor - from another student using ternary
def short_long_short(first_str, second_str)
  first_str.size > second_str.size ? first_str + second_str + first_str : 
                                     second_str + first_str + second_str
end

# # Refactor - LS Solution
# def short_long_short(first_str, second_str)
#   if first_str.size > second_str.size
#     second_str + first_str + second_str
#   else
#     first_str + second_str + first_str
#   end
# end

# LS Solution - using sort + concatenate
def short_long_short(string1, string2)
  strings = [string1, string2].sort_by { |string| string.size }
  strings.first + strings.last + strings.first
end



p short_long_short('abc', 'defgh') == "abcdefghabc"
p short_long_short('abcde', 'fgh') == "fghabcdefgh"
p short_long_short('', 'xyz') == "xyz"