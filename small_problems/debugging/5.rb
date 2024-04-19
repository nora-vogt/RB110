require 'pry'
=begin
Card Deck
- why does the code below raise a TypeError?
- fix it.
- Now the `sum` is off - lower than it should be. Why is that?
=end

# cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

# deck = { :hearts   => cards,
#          :diamonds => cards,
#          :clubs    => cards,
#          :spades   => cards }

# def score(card)
#   case card
#   when :ace   then 11
#   when :king  then 10
#   when :queen then 10
#   when :jack  then 10
#   else card
#   end
# end

# # Pick one random card per suit
# player_cards = []
# deck.keys.each do |suit|
#   cards = deck[suit]
#   cards.shuffle!
#   player_cards << cards.pop
# end
# binding.pry

# # Determine the score of the remaining cards in the deck
# sum = deck.reduce(0) do |sum, (_, remaining_cards)|

#   remaining_cards = remaining_cards.map do |card|
#     score(card)
#   end

#   sum += remaining_cards.sum
# end

# puts sum

=begin
As currently written, line 34 `sum += remaining_cards.sum` raises an error. `sum += remaining_cards.sum` is shorthand for `sum = sum + remaining_cards.sum`, and this code attempts to sum the array referenced by `remaining_cards` before adding the return value to `sum`. 

On this line, `remaining_cards` references an array that contains both integer card numbers for face cards (ex: 8, 10), and symbols for the court cards (:jack, :ace). The `TypeError` is raised because a Symbol cannot be added to an Integer.

To fix this, we need assign the return value of invoking `#map` on `remaining_cards` to a variable, `values`

The code in the block on line 31 invokes the `score` method and passes in the value of the current card as an argument, and `score` will return an `Integer` number of points that the card is worth. 

However, because `#map` is not mutating, it simply returns a new array of card values that is not currently utilized. By assigning `values` to the new array of integer values returned by `#map`, that will ensure that only the Integer values are summed on line 34:
=end

# Fix
# sum = deck.reduce(0) do |sum, (_, remaining_cards)|
#   values = remaining_cards.map do |card|
#     score(card)
#   end

#   sum += values.sum
# end

=begin
Now, the `sum` that is output is too low. This is due to some local variable mutation that happens earler in the code. 

When we try to pick and delete one random card per suit, this code is executed:
=end

# player_cards = []
# deck.keys.each do |suit|
#   cards = deck[suit]
#   cards.shuffle!
#   player_cards << cards.pop
# end


=begin
However, on line 1, the local variable `cards` is initialized and assigned to an array of card values. Due to local variable scoping rules in Ruby, the array referenced by `cards` is accessible within the block that is defined on lines 21-25. 

Additionally, when we look at line 3, the card deck is created with the following code:

deck = { :hearts   => cards,
         :diamonds => cards,
         :clubs    => cards,
         :spades   => cards }


This means that each suit symbol key's value is the same single Array object referenced by `cards` that was initialized on line 1. It is this Array object that is mutated by the block on lines 21-25, when `#shuffle!` and `#pop` are invoked. 

As `#each` iterates, the last card value in the `cards` array is destructively removed by `#pop`, and because this one Array object is currently used to store the values for each of the four suits, we end up with each suit referencing the same array with four card values removed.

After `#each` returns, our `deck` has this erroneous value (for example)

deck # => {:hearts=>[7, 9, :queen, 10, 5, :ace, 2, :jack, 4],
 :diamonds=>[7, 9, :queen, 10, 5, :ace, 2, :jack, 4],
 :clubs=>[7, 9, :queen, 10, 5, :ace, 2, :jack, 4],
 :spades=>[7, 9, :queen, 10, 5, :ace, 2, :jack, 4]}

In order to fix this, we need to initialize our `deck` so that each suit key is paired with a unique Array object value - that one card can be removed from each suit, without also affecting the other suits. 

One way to do that is below. Instead of using `cards` as the value for each suit key, we create a shallow copy of `cards` with `#dup`. `#dup` will return a new Array object with the same values from `cards`.
=end

# Final code:
cards = [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]

deck = { :hearts   => cards.dup,
         :diamonds => cards.dup,
         :clubs    => cards.dup,
         :spades   => cards.dup }

def score(card)
  case card
  when :ace   then 11
  when :king  then 10
  when :queen then 10
  when :jack  then 10
  else card
  end
end

# Pick one random card per suit

player_cards = []
deck.keys.each do |suit|
  cards = deck[suit]
  cards.shuffle!
  player_cards << cards.pop
end

# Determine the score of the remaining cards in the deck

sum = deck.reduce(0) do |sum, (_, remaining_cards)|
  values = remaining_cards.map do |card|
    score(card)
  end

  sum += values.sum
end

puts sum

total_sum  = 4 * [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].sum
player_sum = player_cards.map { |card| score(card) }.sum

puts(sum == total_sum - player_sum) #=> true