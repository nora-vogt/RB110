=begin
Letter Counter (pt 1)

input:
- string (with words separated by spaces)
output:
- hash (keys are word size, values are # of words of that size)

Rules:
- a "word" is a string of characters that does not include a space
- punctuation (commas, quotations, question marks etc) count as part of a word
- an empty string should return an empty hash

EXAMPLES:
word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
four - 4
score - 5
and - 3
seven. - 6

word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
hey - 3
diddle - 6
diddle, - 7
the - 3
cat - 3
and - 3
the - 3
fiddle! - 7

word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
what's - 6
up - 2
doc? - 4

word_sizes('') == {}

DATA STRUCTURE:
start: string
middle: array of words (split on whitespace?)
end: hash (keys - word size; values - occurrences)

ALGORITHM:
Given a string, "string"
- initialize "words", split "string" into words and add words to "words"
  - split should be on whitespace
- initialize "count" assign to empty hash
- iterate through words
  - get the size of the current word, assign to "size"
  - check if size is a key in "count" hash
    - if yes: increment the value of count[current word] by 1
    - if not: create a new k/v pair in "count" - current word is key, 1 is value
- return count hash
=end

def word_sizes(string)
  words = string.split(' ')
  count = {}
  words.each do |word|
    size = word.size
    count[size] ? count[size] += 1 : count[size] = 1
  end

  count
end

p word_sizes('Four score and seven.') == { 3 => 1, 4 => 1, 5 => 1, 6 => 1 }
p word_sizes('Hey diddle diddle, the cat and the fiddle!') == { 3 => 5, 6 => 1, 7 => 2 }
p word_sizes("What's up doc?") == { 6 => 1, 2 => 1, 4 => 1 }
p word_sizes('') == {}

# TIME: 9:52

# LS Solution:
def word_sizes(words_string)
  counts = Hash.new(0)
  words_string.split.each do |word|
    counts[word.size] += 1
  end
  counts
end

=begin
counts = Hash.new(0) -- uses a default argument to initialize a new Hash
- this forces any references to non-existing keys to return 0, instead of nil
- without this, counts[word.size] would return nil for any key that hasn't been created yet, causing counts[word.size] += 1 to raise an error.
- Similar to my solution, but solved the need for a conditional statement with Hash#new(default)
- also saved a step by chaining #each to #split

## Further Exploration
Hash::new and initializing a Hash with default values


new(default_value = nil) → new_hash
new {|hash, key| ... } → new_hash

Hash.new(3) - when referencing a key in the hash that doesn't yet exist, returns 3 instead of nil

hash = Hash.new(3) # => {}
hash[:a] # => 3
hash[:b] = "hello" # => "hello"
hash # => {:b => "hello"}

# Hash::new with only a block - sets the default value to return value of block when referencing a key that doesn't exist yet

animals = Hash.new { |hash, key| "despite #{key}, it's always kittens" }
animals[:dogs] # => "despite dogs, it's always kittens" 

# can't call with an argument and a block together -> ArgumentError

There's also Enumerable#tally
=end