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

def display_player_hand(hand)
  puts "Your cards are:"
  hand.each { |card| puts "#{card[0]} of #{card[1]}" }
end

def display_partial_dealer_hand(hand)
  puts "Dealer's hand is:"
  puts "Mystery card and"
  hand[1..-1].each { |card| puts "#{card[0]} of #{card[1]}" }
end

def get_move_choice
  loop do
    choice = gets.chomp.downcase
    return choice if (['h', 'hit', 's', 'stay']).include?(choice)
    puts "Invalid response. Please enter 'hit' or 'stay':"
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

def dealer_stay?(hand)
  false
end

def winner?(hand)
  calculate_total(hand) == WINNING_SCORE
end

def busted?(hand)
  calculate_total(hand) > WINNING_SCORE
end

def play_again?
  puts "Would you like to play again? ('y' or 'n')"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

loop do
  system "clear"
  puts "Welcome to Twenty-One!"
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
    # 1. if dealer wins, break out of this loop
    # 2. display both full hands (both dealer cards) + winning message
    # 3. ask to play again (1-3 will repeat on dealer's turn if they win)

  loop do # Player Turn
    system "clear"
    #player_hand = [["Ace", "Clubs"], ["10", "Hearts"]] # For testing winning hand
    display_player_hand(player_hand) # player can see both cards
    blank_line
    display_partial_dealer_hand(dealer_hand) # only one dealer card is visible
    blank_line

    break if winner?(player_hand)
    
    puts "Would you like to hit or stay?"
    choice = get_move_choice
    deal_card!(deck, player_hand) if ['h', 'hit'].include?(choice)

    break if ['s', 'stay'].include?(choice) || busted?(player_hand)
  end

  if winner?(player_hand)
    puts "You win with 21 points!"
    next if play_again?
    break
  elsif busted?(player_hand)
    puts "You bust! Dealer wins!"
    next if play_again?
    break
  else
    puts "You chose to stay."
    sleep 1
  end

  loop do # Dealer's Turn
    break if dealer_stay?(dealer_hand) || busted?(dealer_hand)
    puts "Dealer's Turn!"
    puts "Dealer deals themself another card"
    deal_card!(deck, dealer_hand)
    blank_line
    display_partial_dealer_hand(dealer_hand)
  end

  break
end

puts "Thanks for playing Twenty One!"