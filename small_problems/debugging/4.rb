=begin
Reverse Sentence

- return a new string with words of argument in reverse order
- do not use ruby's #reverse method
=end

# def reverse_sentence(sentence)
#   words = sentence.split(' ')
#   reversed_words = []

#   i = 0
#   while i < words.length
#     reversed_words = words[i] + reversed_words #error
#     # words[0] = "how"
#     i += 1
#   end

#   reversed_words.join(' ')
# end

# p reverse_sentence('how are you doing')
# # expected output: 'doing you are how'

=begin
As currently written, line 14 raises an error. `words[i]` returns a `String` object, the string from the `words` array at the index indicated by `i`. This line attempts to concatenate (String#+) the return value of `reversed_words`, which is an `Array`, to the `String` returned by `words[i]`, raising the `TypeError`.

To fix this, line 7 should instead add the current word to the beginning of the `words` array, using a method like `Array#unshift`. 

This will result in `words` containing all the original words in the given sentence in reverse order, which are then joined back into a string by line 19.
=end

def reverse_sentence(sentence)
  words = sentence.split(' ')
  reversed_words = []

  i = 0
  while i < words.length
    reversed_words.unshift(words[i])
    i += 1
  end

  reversed_words.join(' ')
end

p reverse_sentence('how are you doing')
# expected output: 'doing you are how'

# TIME: 4:55

