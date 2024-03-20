require 'pry'

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
CARDS = ('2'..'10').to_a + ['Jack', 'Queen', 'King', 'Ace']

TEN_POINTS = 10
ELEVEN_POINTS = 11
SEVENTEEN_POINTS = 17
WINNING_SCORE = 21

def prompt(message)
  puts "=> #{message}"
end

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
  prompt "Your cards are:"
  hand.each { |card| prompt "#{card[0]} of #{card[1]}" }
  prompt "Your total points are #{calculate_total(hand)}."
end

def display_partial_dealer_hand(hand)
  prompt "Dealer's hand is:"
  prompt "???"
  hand[1..-1].each { |card| prompt "#{card[0]} of #{card[1]}" }
end

def display_full_dealer_hand(hand) # refactor this
  prompt "Dealer's hand is:"
  hand.each { |card| prompt "#{card[0]} of #{card[1]}" }
  prompt "Dealer's total points are #{calculate_total(hand)}."
end

def get_move_choice
  loop do
    choice = gets.chomp.downcase
    return choice if (['h', 'hit', 's', 'stay']).include?(choice)
    prompt "Invalid response. Please enter 'hit' or 'stay':"
  end
end

def player_turn(deck, player_hand, dealer_hand)
  loop do
    prompt "Your turn!"    
    prompt "Would you like to hit or stay?"
    choice = get_move_choice
    if ['h', 'hit'].include?(choice)
      system "clear"
      prompt "You chose to hit."
      blank_line
      deal_card!(deck, player_hand)
      display_player_hand(player_hand)
      blank_line
      display_partial_dealer_hand(dealer_hand)
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
    display_full_dealer_hand(dealer_hand)
    blank_line
    prompt "Dealer's Turn!"

    break if dealer_stay?(dealer_hand) || busted?(dealer_hand)

    prompt "Dealer chooses to hit..."
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
    prompt "You bust! Dealer wins."
  when :dealer_busted
    prompt "Dealer bust! You win!"
  when :player
    prompt "You Win! Yay!"
  when :dealer
    prompt "The Dealer wins with #{calculate_total(dealer_hand)} points!" / 
           " Better luck next time!"
  when :tie
    prompt "It's a tie!"
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
  prompt "Would you like to play again? ('y' or 'n')"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

loop do
  system "clear"
  prompt "Welcome to Twenty-One!"
  deck = initialize_deck
  player_hand = []
  dealer_hand = []
  prompt "Shuffling the deck"
  shuffle_deck!(deck)

  prompt "Dealer deals each player two starting cards..."
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
    play_again? ? next : break
  else
    prompt "You chose to stay."
    sleep 1
  end

  dealer_turn(deck, player_hand, dealer_hand)

  if busted?(dealer_hand)
    display_outcome(player_hand, dealer_hand)
    play_again? ? next : break
  else
    prompt "Dealer chose to stay."
    sleep 1
  end

  # Both Players Stay
  blank_line
  prompt "Both Player and Dealer stay!"
  blank_line
  sleep 1.5

  puts "#{"*" * 30}"
  determine_outcome(player_hand, dealer_hand)
  display_outcome(player_hand, dealer_hand)
  puts "#{"*" * 30}"

  break unless play_again?
end

prompt "Thanks for playing Twenty One!"