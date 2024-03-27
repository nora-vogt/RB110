require 'pry'

SUITS = ["\u2665", "\u2666", "\u2663", "\u2660"]
CARDS = ('2'..'10').to_a + ['J', 'Q', 'K', 'A']
NUMERALS = { 
  2 => 'Twenty', 3 => 'Thirty', 4 => 'Forty', 
  5 => 'Fifty', 6 => 'Sixty', 7 => 'Seventy', 
  8 => 'Eighty', 9 => 'Ninety'
}
TEN_POINTS = 10
ELEVEN_POINTS = 11
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

def initial_deal!(deck, user, dealer)
  2.times do
    deal_card!(deck, user)
    deal_card!(deck, dealer)
  end
end

def initialize_players(deck)
  user_hand = []
  dealer_hand = []
  initial_deal!(deck, user_hand, dealer_hand)

  user_total = calculate_total(user_hand)
  dealer_total = calculate_total(dealer_hand)

  user_stats = { hand: user_hand, total: user_total }
  dealer_stats = { hand: dealer_hand, total: dealer_total, hidden_card: true }

  { user: user_stats, dealer: dealer_stats }
end

def within_valid_range?(string)
  ('21'..'91').to_a.include?(string)
end

def valid_integer?(string)
  string.to_i.to_s == string
end

def ends_in_one?(string)
  string.chars.last == '1'
end

def valid_winning_score?(string)
  valid_integer?(string) && ends_in_one?(string) && within_valid_range?(string)
end

def format_winning_score(integer)
  first_digit = integer.digits.last
  NUMERALS[first_digit] + "-One"
end

def ask_to_start(play)
  prompt "Press enter to start #{play == :game ? 'the game' : 'next round'}:"
  gets.chomp
end

def ask_for_rules
  prompt "Would you like to see the rules? ('Y' or 'N'):"
  loop do
    choice = gets.chomp.downcase
    return choice if ['yes', 'y', 'n', 'no'].include?(choice)
    prompt "Invalid response. Please enter 'Y' or 'N':"
  end
end

def ask_to_customize
  prompt "Would you like to customize the winning score to play 'Whatever-One'?"
  prompt "Enter 'Y' to customize, or 'N' to continue playing Twenty-One:"
  loop do
    input = gets.chomp.downcase
    return input if ['yes', 'y', 'n', 'no'].include?(input)
    prompt "Invalid response. Please enter 'Y' or 'N':"
  end
end



def ask_for_winning_score
  system "clear"
  prompt "Set your own winning score."
  score = nil
  loop do
    prompt "Enter a two-digit number that ends in '1', between 31 and 91 (ex: 31, 51):"
    score = gets.chomp
    break if valid_winning_score?(score)
    prompt "Invalid response."
  end
  score.to_i
end

def display_rules
  system "clear"
  prompt "These are some rules. Placeholder!!"
  prompt "Press 'Enter' to continue:"
  gets.chomp
end

def set_game_constants(max = 21)
  Object.const_set('DEALER_MIN_POINTS', max - 4)
  Object.const_set('MAX_HAND_POINTS', max)
end

def display_introduction
  prompt "Welcome to Twenty-One!"
  rules_choice = ask_for_rules
  display_rules if ['y', 'yes'].include?(rules_choice)
  system "clear"
  choice = ask_to_customize

  if ['y', 'yes'].include?(choice)
    score = ask_for_winning_score
    set_game_constants(score)
    if score == 21
      prompt "No problem, you can stick with Twenty-One!"
    else
      prompt "Okay, you'll play #{format_winning_score(score)}!"
    end
  else
    set_game_constants
    prompt "Great, you'll stick with Twenty-One!"
  end
  
  prompt "Get ready, you'll play until someone wins 5 rounds."
  sleep 4
end

def format_top_card(card, hidden, index)
  if hidden && index == 0
    "|~    |"
  elsif card[0] == '10'
    "|#{card[0]}   |"
  else
    "|#{card[0]}    |"
  end
end

def format_middle_card(card, hidden, index)
  "|  #{hidden && index == 0 ? '~' : card[1]}  |"
end

def format_bottom_card(card, hidden, index)
  if hidden && index == 0
    "|____~|"
  elsif card[0] == '10'
    "|___#{card[0]}|"
  else
    "|____#{card[0]}|"
  end
end

def generate_display_cards!(player_info, lines)
  hidden = player_info[:hidden_card]
  player_info[:hand].each_with_index do |card, index|
    lines[0] << " _____ "
    lines[1] << format_top_card(card, hidden, index)
    lines[2] << format_middle_card(card, hidden, index)
    lines[3] << format_middle_card(card, hidden, index)
    lines[4] << format_bottom_card(card, hidden, index)
  end
end

def display_cards(player_info)
  lines = ["", "", "", "", ""]
  generate_display_cards!(player_info, lines)
  lines.each { |line| puts line }
end

def display_user_hand(user_info)
  prompt "Your cards are:"
  display_cards(user_info)
  prompt "Your total points are #{user_info[:total]}."
end

def display_dealer_hand(dealer_info)
  prompt "Dealer's hand is:"
  display_cards(dealer_info)

  points = dealer_info[:hidden_card] ? 'hidden' : dealer_info[:total]
  prompt "Dealer's total points are #{points}."
end

def display_hands(players)
  display_dealer_hand(players[:dealer])
  display_blank_line
  display_user_hand(players[:user])
  display_blank_line
end

def reveal_dealer_hidden_card!(dealer_stats)
  dealer_stats[:hidden_card] = false
end

def ask_hit_or_stay
  loop do
    choice = gets.chomp.downcase
    return choice if (['h', 'hit', 's', 'stay']).include?(choice)
    prompt "Invalid response. Please enter 'hit' or 'stay':"
  end
end

def user_turn(deck, players, scoreboard)
  user_stats = players[:user]
  prompt "Your turn!"
  loop do
    prompt "Would you like to 'hit' or 'stay'?"
    choice = ask_hit_or_stay

    if ['h', 'hit'].include?(choice)
      system "clear"
      deal_card!(deck, user_stats[:hand])
      update_total!(user_stats)
      display_game_info(players, scoreboard)
      prompt "You chose to hit."
      sleep 1
    end

    break if ['s', 'stay'].include?(choice) || busted?(user_stats[:total])
  end
end

def dealer_turn(deck, players, scoreboard)
  dealer_stats = players[:dealer]
  loop do
    system "clear"
    display_game_info(players, scoreboard)

    break if dealer_stay?(dealer_stats[:total]) || busted?(dealer_stats[:total])

    prompt "Dealer's Turn!"
    prompt "Dealer chooses to hit..."
    display_blank_line
    deal_card!(deck, dealer_stats[:hand])
    update_total!(dealer_stats)
    sleep 2
  end
end

def update_round_number!(scoreboard)
  scoreboard[:round] += 1
end

def determine_round_outcome(players)
  user_total = players[:user][:total]
  dealer_total = players[:dealer][:total]

  if user_total > MAX_HAND_POINTS
    :user_busted
  elsif dealer_total > MAX_HAND_POINTS
    :dealer_busted
  elsif user_total > dealer_total
    :user
  elsif dealer_total > user_total
    :dealer
  else
    :tie
  end
end

def update_score!(scoreboard, outcome)
  case outcome
  when :user_busted, :dealer then scoreboard[:dealer] += 1
  when :dealer_busted, :user then scoreboard[:user] += 1
  when :tie                  then scoreboard[:tie] += 1
  end
end

def display_round_outcome(players, outcome)
  user_total = players[:user][:total]
  dealer_total = players[:dealer][:total]

  case outcome
  when :user_busted
    prompt "You bust! Dealer wins."
  when :dealer_busted
    prompt "Dealer bust! You win!"
  when :user
    prompt "You win this round with #{user_total} points!"
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
  puts "-----------#{format_winning_score(MAX_HAND_POINTS).upcase}-----------"
  puts "Player: #{scoreboard[:user]}"
  puts "Dealer: #{scoreboard[:dealer]}"
  puts "Ties: #{scoreboard[:tie]}"
  puts "-----------ROUND #{scoreboard[:round]}-----------"
end

def display_game_info(players, scoreboard)
  display_scoreboard(scoreboard)
  display_hands(players)
end

def determine_game_winner(scoreboard)
  if scoreboard[:user] == 5
    :user
  elsif scoreboard[:dealer] == 5
    :dealer
  end
end

def display_game_winner(scoreboard)
  winner = determine_game_winner(scoreboard)
  display_blank_line
  puts '*' * 80
  case winner
  when :user
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
    sum = if value == 'A'
            sum + ELEVEN_POINTS
          elsif ('2'..'10').include?(value)
            sum + value.to_i
          else # Jack, Queen, King
            sum + TEN_POINTS
          end
  end

  values.count('A').times { sum -= TEN_POINTS if sum > MAX_HAND_POINTS }
  sum
end

def update_total!(player)
  player[:total] = calculate_total(player[:hand])
end

def dealer_stay?(total)
  (DEALER_MIN_POINTS..MAX_HAND_POINTS).include?(total)
end

def busted?(total)
  total > MAX_HAND_POINTS
end

def game_won?(scoreboard)
  scores = scoreboard.select { |k, _| k == :user || k == :dealer }
  scores.any? { |_, v| v == GAME_WINNING_SCORE }
end

def play_again?
  display_blank_line
  prompt "Would you like to play again? ('y' or 'n')"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

def play_round(players, deck, scoreboard)
  system "clear"
  display_game_info(players, scoreboard)

  user_turn(deck, players, scoreboard)
  reveal_dealer_hidden_card!(players[:dealer])
  return if busted?(players[:user][:total])
  prompt "You chose to stay."
  sleep 2

  dealer_turn(deck, players, scoreboard)
  return if busted?(players[:dealer][:total])
  prompt "Dealer chose to stay."
  sleep 2
end

loop do
  system "clear"
  display_introduction
  scoreboard = { user: 0, dealer: 0, tie: 0, round: 1 }

  loop do
    deck = initialize_deck
    players = initialize_players(deck)

    play_round(players, deck, scoreboard)

    system "clear"
    outcome = determine_round_outcome(players)
    update_score!(scoreboard, outcome)
    display_end_of_round(players, scoreboard, outcome)

    break if game_won?(scoreboard)

    update_round_number!(scoreboard)
    ask_to_start(:round)
  end

  display_game_winner(scoreboard)
  break unless play_again?
end

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
