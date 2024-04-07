=begin
Letter Counter (part 2)

PROBLEM
Modify word_sizes method to exclude non-letters when determining word size. 

it's -> 3, not 4

EXAMPLES
word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
what's -> whats -> 5
up -> 2
doc? -> doc -> 3

word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
hey -> 3
diddle -> 6
diddle, -> diddle -> 6
the -> 3
cat -> 3
and -> 3
the -> 3
fiddle! -> fiddle -> 6

DATA STRUCTURE
start: string
middle: array
end: hash

ALGORITHM
Given a string, "string"
Given the "word_sizes" method that returns a hash of size keys and # of occurences values
- remove all non-alphabetic characters from "string", before splitting on whitespace
  - check if character is anything other than alphabetic char or whitespace
  - remove the character from the string if so
- rest of method stays the same

=end

# def word_sizes(string)
#   counts = Hash.new(0)
#   string.gsub(/[^a-zA-Z\s]/, '').split(' ').each do |word|
#     counts[word.size] += 1
#   end

#   counts
# end

# cleaning up each word while iterating through the array of words
def word_sizes(string)
  counts = Hash.new(0)
  string.split(' ').each do |word|
    clean_word = word.delete('^a-zA-Z')
    counts[clean_word.size] += 1
  end
  counts
end


p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 2 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 3 }
p word_sizes("What's up doc?") == { 5 => 1, 2 => 1, 3 => 1 }
p word_sizes('') == {}