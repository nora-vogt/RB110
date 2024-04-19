def neutralize(sentence)
  words = sentence.split(' ')
  words.each_with_index do |word, index|
    p index
    p word
    p words
    words.delete(word) if negative?(word)
  end

  words.join(' ')
end

def negative?(word)
  [ 'dull',
    'boring',
    'annoying',
    'chaotic'
  ].include?(word)
end

puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.

=begin
Not all negative words are being removed by the `neutralize` method due to the use of the destructive `Array#delete` method to remove negative words. 

The `neutralize` method is invoked on line 18 and passed a string argument. Within the `neutralize` method definition, the parameter `sentence` is bound to the string passed in as an argument. Within the method defintion on line 1, the local variabl `words` is assigned to an array containing each word in `sentence` as an element. 

On line 3, the `#each` method is used to iterate through the array of words referenced by `words`. `#each` takes a `do..end` block argument defined on lines 3-5, with one block parameter `word`. As `#each` iterates, each string in `words` will be bound to `word`.

Within the block on line 4, the `Array#delete` method is invoked to delete the current word from `words` if it is a negative word. `Array#delete` mutates its calling array. On the second iteration of `#each`, `word` references `"dull"``, which is found in the list of negative words defined in `negative?`, so `Array#delete` executes and destructively removes `"dull"` from `words`.

`words` now has a value of `["These", "boring", "cards", "are", "part", "of", "a", "chaotic", "board", "game."]`. Because `Array#delete` mutated `words`, each element in `words` has been shifted to a new index position. This is why `"boring"` is skipped and not removed from the array, even though it is a negative word. `"boring"` is now at index position 1, and `#each` begins the third iteration passing the element at index position 2 to `word` - skipping "boring" entirely.

Unexpected results like this can occur when mutating the object that is being iterated through. 

TIME: 9:05

To fix this, we could rewrite the code to use `Array#reject!`, for example, which is an iterative method that mutates the calling array, rejecting any elements for which the block returns a truthy value. In this case, we change the code in the block to simply invoke the `negative?` method and pass in the current value of `word` as an argument, and `negative?` will return `true` if `word` is negative.

TIME: 11 - to add solution paragraph + code changes below.
=end
# def neutralize(sentence)
#   words = sentence.split(' ')
#   words.reject! { |word| negative?(word) }
#   words.join(' ')
# end

# def negative?(word)
#   [ 'dull',
#     'boring',
#     'annoying',
#     'chaotic'
#   ].include?(word)
# end

# puts neutralize('These dull boring cards are part of a chaotic board game.')
# Expected: These cards are part of a board game.
# Actual: These boring cards are part of a board game.
