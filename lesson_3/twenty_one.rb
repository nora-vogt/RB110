require 'pry'

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
CARDS = ('2'..'10').to_a + ['Jack', 'Queen', 'King', 'Ace']

TEN_POINTS = 10
ELEVEN_POINTS = 11
WINNING_SCORE = 21

def blank_line
  puts ""
end

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
  2.times do # alternates deal order, like a real card game
    deal_card!(deck, player_hand)
    deal_card!(deck, dealer_hand)
  end
end

def winner?(hand)
  calculate_total(hand) == WINNING_SCORE
end

def busted?(hand)
  calculate_total(hand) > WINNING_SCORE
end

def display_player_hand(hand)
  puts "Your cards are:"
  hand.each { |card| puts "#{card[0]} of #{card[1]}" }
end

def display_dealer_hand(hand)
  puts "Dealer's hand is:"
  puts "#{hand[0][0]} of #{hand[0][1]} and mystery card"
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
  blank_line

  puts "Your turn!"
  sleep 1.5
  # need to check if dealer wins after initial deal here

  loop do # Player Turn
    system "clear"
    display_player_hand(player_hand) # player can see both cards
    blank_line
    display_dealer_hand(dealer_hand) # only one dealer card is visible
    blank_line

    break if winner?(player_hand)
    
    puts "Would you like to hit or stay?"
    answer = gets.chomp.downcase

    deal_card!(deck, player_hand) if answer == "hit"

    break if answer == "stay" || busted?(player_hand)
  end

  if winner?(player_hand)
    puts "You win with 21 points!"
  elsif busted?(player_hand)
    puts "You bust! Dealer wins!"
  else
    puts "You chose to stay. Dealer's Turn!"
  end

  break
end