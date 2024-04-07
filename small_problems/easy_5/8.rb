=begin
Alphabetical Numbers

Given an array of integers between 0-19 (inclusive), return a new array with those integers sorted according to the English word for each number. 

Input:
- array of integers

Output:
- array (integers sorted based on english words)

Rules:
- sort numbers based on english word. for example 0 comes after 4 ("zero" is after "four" alphabetically)
- array will only contain integers between 0..19, inclusive
- sort based on lower-case english word equivalents of integers
- array returned will contain INTEGERS, not words, just sort on the words

Qs
- should we return a new array, or mutate the given array? 

EXAMPLES:
zero, one, two, three, four, five, six, seven, eight, nine, ten, eleven, twelve, thirteen, fourteen, fifteen, sixteen, seventeen, eighteen, nineteen

DATA STRUCTURE:
start: array of integers
middle: hash to look up integer => english word
end: array of sorted integers

ALGORITHM:
Given an array of integers, "numbers"
- Create "INTEGER_TO_WORD" to reference a hash, where keys are integers and values are string word equivalents of the number (0 => "zero")
- iterate through numbers and sort by
  - look up current number as key in INTEGER_TO_WORD hash, return the value as sort criteria
- return the sorted array
=end

INTEGER_TO_WORDS = { 0 => 'zero', 1 => 'one', 2 => 'two', 
                     3 => 'three', 4 => 'four', 5 => 'five', 
                     6 => 'six', 7 => 'seven', 8 => 'eight', 
                     9 => 'nine', 10 => 'ten', 11 => 'eleven', 
                     12 => 'twelve', 13 => 'thirteen', 14 => 'fourteen', 
                     15 => 'fifteen', 16 => 'sixteen', 17 => 'seventeen', 
                     18 => 'eighteen', 19 => 'nineteen'

}

# Original Solution
def alphabetic_number_sort(numbers)
  numbers.sort_by { |number| INTEGER_TO_WORDS[number] }
end

p alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]


# LS Solution
# The same, but used an array of number words instead of a hash. This is easier! Because the numbers start at 0, each number-word matches its index, so we can reference number by index.

# Further Exploration
# Array#sort_by! mutates the calling array, this problem wanted to preserve the original array and return a new array.

# Rewrite using Enumerable#sort
NUMBER_WORDS = %w(zero one two three four
                  five six seven eight nine
                  ten eleven twelve thirteen fourteen
                  fifteen sixteen seventeen eighteen nineteen)

def alphabetic_number_sort(numbers)
  numbers.sort do |a, b|
    NUMBER_WORDS[a] <=> NUMBER_WORDS[b]
  end
end

p alphabetic_number_sort((0..19).to_a) == [
  8, 18, 11, 15, 5, 4, 14, 9, 19, 1, 7, 17,
  6, 16, 10, 13, 3, 12, 2, 0
]