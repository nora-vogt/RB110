require 'pry'

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
CARDS = ('2'..'10').to_a + ['Jack', 'Queen', 'King', 'Ace']

TEN_POINTS = 10
ELEVEN_POINTS = 11
WINNING_SCORE = 21

def initialize_deck
  CARDS.product(SUITS)
end

def shuffle!(deck)
  deck.shuffle!
end

def deal_card!(deck, hand)
  hand << deck.shift
end

def initial_deal!(deck, player_hand, dealer_hand)
  2.times do 
    deal_card!(deck, player_hand)
    deal_card!(deck, dealer_hand)
  end
end

def calculate_total(hand)
  values = hand.map {|card| card.first }
  sum = 0

  values.each do |value|
    if value == 'Ace'
      sum += ELEVEN_POINTS
    elsif ('2'..'10').include?(value)
      sum += value.to_i
    else # Jack, Queen, King
      sum += TEN_POINTS
    end
  end

  # Correct for Aces - per each Ace, if the sum is greater than 21, minus 10 points
  values.count("Ace").times { sum -= 10 if sum > 21 }
  sum
end

loop do # start game
  deck = initialize_deck
  player_hand = []
  dealer_hand = []
  puts "Shuffling the deck"
  shuffle!(deck)

  puts "Dealer deals each player two starting cards"
  initial_deal!(deck, player_hand, dealer_hand)

  break
end