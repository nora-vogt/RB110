require 'pry'

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
CARDS = ('2'..'10').to_a + ['Jack', 'Queen', 'King', 'Ace']

TEN_POINTS = 10
ELEVEN_POINTS = 11
SEVENTEEN_POINTS = 17
WINNING_SCORE = 21

def blank_line
  puts ""
end

def initialize_deck
  CARDS.product(SUITS)
end

def shuffle_deck!(deck)
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
  puts "Your total points are #{calculate_total(hand)}."
end

def display_partial_dealer_hand(hand)
  puts "Dealer's hand is:"
  puts "???"
  hand[1..-1].each { |card| puts "#{card[0]} of #{card[1]}" }
end

def display_full_dealer_hand(hand) # refactor this
  puts "Dealer's hand is:"
  hand.each { |card| puts "#{card[0]} of #{card[1]}" }
end

def get_move_choice
  loop do
    choice = gets.chomp.downcase
    return choice if (['h', 'hit', 's', 'stay']).include?(choice)
    puts "Invalid response. Please enter 'hit' or 'stay':"
  end
end

def player_turn(deck, player_hand, dealer_hand)
  loop do # Player Turn
    puts "Your turn!"    
    puts "Would you like to hit or stay?"
    choice = get_move_choice
    if ['h', 'hit'].include?(choice)
      system "clear"
      puts "You chose to hit."
      blank_line
      deal_card!(deck, player_hand)
      display_player_hand(player_hand) # player can see both cards
      blank_line
      display_partial_dealer_hand(dealer_hand) # only one dealer card is visible
      blank_line
    end

    break if ['s', 'stay'].include?(choice) || busted?(player_hand)
  end
end

def dealer_turn(deck, player_hand, dealer_hand)
  loop do
    system "clear"
    display_player_hand(player_hand)
    blank_line
    display_partial_dealer_hand(dealer_hand)
    blank_line
    puts "Dealer's Turn!"

    break if dealer_stay?(dealer_hand) || busted?(dealer_hand)

    puts "Dealer chooses to hit..."
    blank_line
    deal_card!(deck, dealer_hand)

    blank_line
    sleep 2
  end
end

def determine_outcome(player_hand, dealer_hand)
  player_score = calculate_total(player_hand)
  dealer_score = calculate_total(dealer_hand)

  if player_score > WINNING_SCORE
    :player_busted
  elsif dealer_score > WINNING_SCORE
    :dealer_busted
  elsif player_score > dealer_score
    :player
  elsif dealer_score > player_score
    :dealer
  else
    :tie
  end
end

def display_outcome(player_hand, dealer_hand)
  outcome = determine_outcome(player_hand, dealer_hand)

  case outcome
  when :player_busted
    puts "You bust! Dealer wins."
  when :dealer_busted
    puts "Dealer bust! You win!"
  when :player
    puts "You Win! Yay!"
  when :dealer
    puts "The Dealer wins! Better luck next time!"
  when :tie
    puts "It's a tie!"
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
  values.count("Ace").times { sum -= TEN_POINTS if sum > WINNING_SCORE }
  sum
end

def dealer_stay?(hand)
  (SEVENTEEN_POINTS..WINNING_SCORE).include?(calculate_total(hand))
end

def twenty_one?(hand)
  calculate_total(hand) == WINNING_SCORE
end

def busted?(hand)
  calculate_total(hand) > WINNING_SCORE
end

def play_again?
  blank_line
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
  shuffle_deck!(deck)

  puts "Dealer deals each player two starting cards..."
  initial_deal!(deck, player_hand, dealer_hand)

  sleep 1.5
  system "clear"
  # need to check if EITHER PLAYER wins after initial deal
    # 0. Blackjack rules: If either dealer or player has "natural" 21 from the deal, it's a tie.
    # 1. determine if either player has 21, if yes
    # 2. display both full hands (both dealer cards) + winning message
    # 3. ask to play again (1-3 will repeat on dealer's turn if they win)
  # player_hand = [["Ace", "Clubs"], ["10", "Hearts"]] # For testing winning hand
  display_player_hand(player_hand) # player can see both cards
  blank_line
  display_partial_dealer_hand(dealer_hand) # only one dealer card is visible
  blank_line

  player_turn(deck, player_hand, dealer_hand) # player turn loop

  if busted?(player_hand)
    display_outcome(player_hand, dealer_hand)
    #puts "You bust! Dealer wins!" # display_outcome
    play_again? ? next : break
  else
    puts "You chose to stay."
    sleep 1
  end

  dealer_turn(deck, player_hand, dealer_hand)

  if busted?(dealer_hand)
    display_outcome(player_hand, dealer_hand)
    #puts "Dealer bust! You win!" # display_outcome
    play_again? ? next : break
  else
    puts "Dealer chose to stay."
  end

  # Both Players Stay
  blank_line
  puts "Both Player and Dealer stay!"
  puts "Counting final points..."
  blank_line
  sleep 1

  determine_outcome(player_hand, dealer_hand)
  display_outcome(player_hand, dealer_hand)

  break unless play_again?
end

puts "Thanks for playing Twenty One!"