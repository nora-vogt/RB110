require 'pry'

SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
CARDS = ('2'..'10').to_a + ['Jack', 'Queen', 'King', 'Ace']

TEN_POINTS = 10
ELEVEN_POINTS = 11
SEVENTEEN_POINTS = 17
MAX_HAND_POINTS = 21
GAME_WINNING_SCORE = 5

def prompt(message)
  puts "=> #{message}"
end

def display_blank_line
  puts ""
end

def initialize_deck
  CARDS.product(SUITS).shuffle
end

def deal_card!(deck, hand)
  hand << deck.shift
end

def initial_deal!(deck, player, dealer)
  2.times do
    deal_card!(deck, player)
    deal_card!(deck, dealer)
  end
end

def initialize_players(deck)
  player_hand = []
  dealer_hand = []
  initial_deal!(deck, player_hand, dealer_hand)

  player_total = calculate_total(player_hand)
  dealer_total = calculate_total(dealer_hand)

  player = { hand: player_hand, total: player_total }
  dealer = { hand: dealer_hand, total: dealer_total, hidden_card: true }

  {player: player, dealer: dealer}
end

def ask_to_continue(play)
  prompt "Press enter to start #{ play == :game ? "the game" : "next round" }:"
  gets.chomp
end

def display_introduction
  prompt "Welcome to Twenty-One!"
  prompt "Rules go here. First player to win 5 rounds wins!"
  ask_to_continue(:game)
end

def display_cards(hand)
  hand.each { |card| prompt "#{card[0]} of #{card[1]}" }
end

def display_player_hand(player_info)
  prompt "Your cards are:"
  display_cards(player_info[:hand])
  prompt "Your total points are #{player_info[:total]}."
end

def display_dealer_hand(dealer_info)
  prompt "Dealer's hand is:"
  if dealer_info[:hidden_card]
    prompt "???"
    dealer_info[:hand][1..-1].each { |card| prompt "#{card[0]} of #{card[1]}" }
  else
    display_cards(dealer_info[:hand])
    prompt "Dealer's total points are #{dealer_info[:total]}."
  end
end

def display_hands(players)
  display_player_hand(players[:player])
  display_blank_line
  display_dealer_hand(players[:dealer])
  display_blank_line
end

def reveal_dealer_hidden_card!(players)
  players[:dealer][:hidden_card] = false
end

def ask_hit_or_stay
  loop do
    choice = gets.chomp.downcase
    return choice if (['h', 'hit', 's', 'stay']).include?(choice)
    prompt "Invalid response. Please enter 'hit' or 'stay':"
  end
end

def player_turn(deck, players, scoreboard)
  player_stats = players[:player]
  loop do
    prompt "Your turn!"
    prompt "Would you like to 'hit' or 'stay'?"
    choice = ask_hit_or_stay

    if ['h', 'hit'].include?(choice)
      system "clear"
      deal_card!(deck, player_stats[:hand])
      player_stats[:total] = calculate_total(player_stats[:hand])
      display_game_info(players, scoreboard)
      prompt "You chose to hit."
    end
  
    break if ['s', 'stay'].include?(choice) || busted?(player_stats[:total])
  end
end

def dealer_turn(deck, players, scoreboard)
  dealer_stats = players[:dealer]
  reveal_dealer_hidden_card!(players)

  loop do
    system "clear"
    dealer_stats[:total] = calculate_total(dealer_stats[:hand])
    display_game_info(players, scoreboard)
  
    break if dealer_stay?(dealer_stats[:total]) || busted?(dealer_stats[:total])

    prompt "Dealer's Turn!"
    prompt "Dealer chooses to hit..."
    display_blank_line
    deal_card!(deck, dealer_stats[:hand])
    display_blank_line
    sleep 2
  end
end

def update_score!(scoreboard, winner)
  scoreboard[winner] += 1
end

def update_round_number!(scoreboard)
  scoreboard[:round] += 1
end

def determine_round_outcome(players, scoreboard)
  player_total = players[:player][:total]
  dealer_total = players[:dealer][:total]

  if player_total > MAX_HAND_POINTS
    update_score!(scoreboard, :dealer)
    :player_busted
  elsif dealer_total > MAX_HAND_POINTS
    update_score!(scoreboard, :player)
    :dealer_busted
  elsif player_total > dealer_total
    update_score!(scoreboard, :player)
    :player
  elsif dealer_total > player_total
    update_score!(scoreboard, :dealer)
    :dealer
  else
    update_score!(scoreboard, :tie)
    :tie
  end
end

def display_round_outcome(players, outcome)
  player_total = players[:player][:total]
  dealer_total = players[:dealer][:total]

  case outcome
  when :player_busted
    prompt "You bust! Dealer wins."
  when :dealer_busted
    prompt "Dealer bust! You win!"
  when :player
    prompt "You win this round with #{player_total} points!"
  when :dealer
    prompt "The Dealer wins this round with #{dealer_total} points!"
  when :tie
    prompt "It's a tie!"
  end
end

def display_end_of_round(players, scoreboard, outcome)
  display_game_info(players, scoreboard)
  display_round_outcome(players, outcome)
end

def display_scoreboard(scoreboard)
  puts "---------SCORES---------"
  puts "Player: #{scoreboard[:player]}"
  puts "Dealer: #{scoreboard[:dealer]}"
  puts "Ties: #{scoreboard[:tie]}"
  puts "---------ROUND #{scoreboard[:round]}---------"
end

def display_game_info(players, scoreboard)
  display_scoreboard(scoreboard)
  display_hands(players)
end

def determine_game_winner(scoreboard)
  if scoreboard[:player] == 5
    :player
  elsif scoreboard[:dealer] == 5
    :dealer
  end
end

def display_game_winner(scoreboard)
  winner = determine_game_winner(scoreboard)
  display_blank_line
  puts '*' * 80
  case winner
  when :player
    prompt "You win the game! Congratulations!"
  when :dealer
    prompt "The Dealer wins the game! Better luck next time."
  end
  puts '*' * 80
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

  values.count("Ace").times { sum -= TEN_POINTS if sum > MAX_HAND_POINTS }
  sum
end

def dealer_stay?(total)
  (SEVENTEEN_POINTS..MAX_HAND_POINTS).include?(total)
end

def busted?(total)
  total > MAX_HAND_POINTS
end

def game_won?(scoreboard)
  scores = scoreboard.select { |k, _| k == :player || k == :dealer }
  scores.any? { |_, v| v == GAME_WINNING_SCORE }
end

def play_again?
  display_blank_line
  prompt "Would you like to play again? ('y' or 'n')"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

loop do # MAIN GAME LOOP
  system "clear"
  display_introduction
  scoreboard = { player: 0, dealer: 0, tie: 0, round: 1 }

  loop do # ROUND LOOP
    system "clear"
    deck = initialize_deck
    players = initialize_players(deck)

    display_game_info(players, scoreboard)

    player_turn(deck, players, scoreboard)

    if busted?(players[:player][:total])
      system "clear"
      outcome = determine_round_outcome(players, scoreboard)
      reveal_dealer_hidden_card!(players)
      display_end_of_round(players, scoreboard, outcome)

      break if game_won?(scoreboard)
      ask_to_continue(:round)
      update_round_number!(scoreboard)
      next
    else
      prompt "You chose to stay."
      sleep 1
    end

    dealer_turn(deck, players, scoreboard)

    if busted?(players[:dealer][:total])
      system "clear"
      outcome = determine_round_outcome(players, scoreboard)
      display_end_of_round(players, scoreboard, outcome)
    
      break if game_won?(scoreboard)
      ask_to_continue(:round)
      update_round_number!(scoreboard)
      next
    else
      prompt "Dealer chose to stay."
      sleep 2
    end

    display_blank_line
    prompt "Both Player and Dealer stay!"
    display_blank_line
    sleep 2

    system "clear"
    outcome = determine_round_outcome(players, scoreboard)
    display_end_of_round(players, scoreboard, outcome)

    break if game_won?(scoreboard)
    ask_to_continue(:round)
    update_round_number!(scoreboard)
  end # END ROUND LOOP

  display_game_winner(scoreboard)
  break unless play_again?
end # END MAIN GAME LOOP

prompt "Thanks for playing Twenty One!"

=begin
Bonus #2: The final call to `play_again?` is different than the previous two
invocations. With this call, `play_again?` returning `true` will continue to
the next iteration of the game loop. Returning `false` will break out of the
loop and end the game. 

With both of the two prior calls, `play_again?` returning `true`` executes the
`next` command, which skips to the next iteration of the main game loop
skipping all subsequent code to restart the game. This is necessary in order to
end and restart the game "early" on a bust. `play_again?` returning `false`
performs same as the final invocation, executing `break` and ending the game.
=end
