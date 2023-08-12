# Let's implement a loop that iterates over a given string and prints each character.

#alphabet = 'abcdefghijklmnopqrstuvwxyz'
alphabet = ''
counter = 0

loop do
  break if counter >= alphabet.size
  puts alphabet[counter]
  counter += 1
end

# We need the conditional first. If it were last, an empty string would cause an infinite loop.
# Also consider edge cases: what if counter somehow surpassed length of alphabet? In this case, use >= instead