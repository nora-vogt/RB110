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
  CARDS.product(SUITS).shuffle
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

def display_player_hand(hand, total)
  prompt "Your cards are:"
  hand.each { |card| prompt "#{card[0]} of #{card[1]}" }
  prompt "Your total points are #{total}."
end

def display_partial_dealer_hand(hand)
  prompt "Dealer's hand is:"
  prompt "???"
  hand[1..-1].each { |card| prompt "#{card[0]} of #{card[1]}" }
end

def display_initial_hands(player_hand, player_total, dealer_hand)
  display_player_hand(player_hand, player_total) # player can see both cards
  blank_line
  display_partial_dealer_hand(dealer_hand) # only one dealer card is visible
  blank_line
end

def display_full_dealer_hand(hand, total) # refactor this - can partial and total be one method?
  prompt "Dealer's hand is:"
  hand.each { |card| prompt "#{card[0]} of #{card[1]}" }
  prompt "Dealer's total points are #{total}."
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
    prompt "Would you like to 'hit' or 'stay'?"
    choice = get_move_choice
    if ['h', 'hit'].include?(choice)
      system "clear"
      deal_card!(deck, player_hand)
      player_total = calculate_total(player_hand)
      display_initial_hands(player_hand, player_total, dealer_hand)
      prompt "You chose to hit."
    end

    break if ['s', 'stay'].include?(choice) || busted?(player_total)
  end
end

def dealer_turn(deck, player_hand, player_total, dealer_hand)
  loop do
    system "clear"
    dealer_total = calculate_total(dealer_hand)
    display_player_hand(player_hand, player_total)
    blank_line
    display_full_dealer_hand(dealer_hand, dealer_total)
    blank_line
    prompt "Dealer's Turn!"

    break if dealer_stay?(dealer_total) || busted?(dealer_total)

    prompt "Dealer chooses to hit..."
    blank_line
    deal_card!(deck, dealer_hand)
    blank_line
    sleep 2
  end
end

def determine_outcome(player_total, dealer_total)
  if player_total > WINNING_SCORE
    :player_busted
  elsif dealer_total > WINNING_SCORE
    :dealer_busted
  elsif player_total > dealer_total
    :player
  elsif dealer_total > player_total
    :dealer
  else
    :tie
  end
end

def display_outcome(player_total, dealer_total)
  outcome = determine_outcome(player_total, dealer_total)

  case outcome
  when :player_busted
    prompt "You bust! Dealer wins."
  when :dealer_busted
    prompt "Dealer bust! You win!"
  when :player
    prompt "You win with #{player_total} points! " \
           "Congrats!"
  when :dealer
    prompt "The Dealer wins with #{dealer_total} points! " \
           "Better luck next time!"
  when :tie
    prompt "It's a tie!"
  end
end

def calculate_total(hand)
  values = hand.map(&:first)
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
  # Correct for Aces - per Ace, if the sum is greater than 21, minus 10 points
  values.count("Ace").times { sum -= TEN_POINTS if sum > WINNING_SCORE }
  sum
end

def dealer_stay?(total)
  (SEVENTEEN_POINTS..WINNING_SCORE).include?(total)
end

def twenty_one?(total)
  total == WINNING_SCORE
end

def busted?(total)
  total > WINNING_SCORE
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
  prompt "Rules go here."
  deck = initialize_deck
  player_hand = []
  dealer_hand = []

  prompt "Dealer deals each player two starting cards..."
  initial_deal!(deck, player_hand, dealer_hand)
  player_total = calculate_total(player_hand)
  dealer_total = calculate_total(dealer_hand)
  sleep 1.5

  system "clear"
  display_initial_hands(player_hand, player_total, dealer_hand)
  player_turn(deck, player_hand, dealer_hand)
  player_total = calculate_total(player_hand)

  if busted?(player_total)
    display_outcome(player_total, dealer_total)
    play_again? ? next : break
  else
    prompt "You chose to stay."
    sleep 1
  end

  dealer_turn(deck, player_hand, player_total, dealer_hand)
  dealer_total = calculate_total(dealer_hand)

  if busted?(dealer_total)
    display_outcome(player_total, dealer_total)
    play_again? ? next : break
  else
    prompt "Dealer chose to stay."
    sleep 1
  end

  blank_line
  prompt "Both Player and Dealer stay!"
  blank_line
  sleep 1.5

  puts '*' * 80
  determine_outcome(player_total, dealer_total)
  display_outcome(player_total, dealer_total)
  puts '*' * 80

  break unless play_again?
end

prompt "Thanks for playing Twenty One!"
