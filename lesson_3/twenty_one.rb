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

def display_full_dealer_hand(hand) # refactor this
  puts "Dealers hand is:"
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
    system "clear"
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
end

def dealer_turn(deck, player_hand, dealer_hand)
  loop do
    system "clear"
    blank_line
    display_player_hand(player_hand)
    blank_line
    display_partial_dealer_hand(dealer_hand)
    blank_line
    puts "Dealer's Turn!"

    break if dealer_stay?(dealer_hand) || busted?(dealer_hand)

    puts "Dealer deals themself another card..."
    blank_line
    deal_card!(deck, dealer_hand)

    break if winner?(dealer_hand)

    blank_line
    sleep 2
  end
end

def determine_winner(player_score, dealer_score)
  if player_score > dealer_score
    'Player'
  elsif dealer_score > player_score
    'Dealer'
  else
    'tie'
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
  (SEVENTEEN_POINTS...WINNING_SCORE).include?(calculate_total(hand))
end

def winner?(hand)
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
  shuffle!(deck)

  puts "Dealer deals each player two starting cards..."
  initial_deal!(deck, player_hand, dealer_hand)
  blank_line

  puts "Your turn!"
  sleep 1.5
  # need to check if dealer wins after initial deal here
    # 1. if dealer wins, break out of this loop
    # 2. display both full hands (both dealer cards) + winning message
    # 3. ask to play again (1-3 will repeat on dealer's turn if they win)
  # player_hand = [["Ace", "Clubs"], ["10", "Hearts"]] # For testing winning hand
  player_turn(deck, player_hand, dealer_hand) # player turn loop

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

  dealer_turn(deck, player_hand, dealer_hand)

  if winner?(dealer_hand)
    puts "Dealer wins with 21 points!"
    next if play_again?
    break
  elsif busted?(dealer_hand)
    puts "Dealer bust! You win!"
    next if play_again?
    break
  else
    puts "Dealer chose to stay."
  end

  # Both Players Stay
  blank_line
  puts "Both Player and Dealer stay!"
  puts "Counting final points..."
  blank_line
  sleep 1
  player_score = calculate_total(player_hand)
  dealer_score = calculate_total(dealer_hand)
  winner = determine_winner(player_score, dealer_score)

  if winner == "tie"
    puts "It's a tie! Player has #{player_score} points and dealer has #{dealer_score} points."
  elsif winner == "Dealer"
    puts "#{winner} wins with #{dealer_score} points! You have #{player_score} points."
    puts "Better luck next time!"
  else
    puts "You win with #{player_score} points! Dealer has #{dealer_score}."
    puts "Yay!"
  end

  break unless play_again?
end

puts "Thanks for playing Twenty One!"