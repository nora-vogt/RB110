require 'pry'

WINNING_LINES = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
  [1, 4, 7], [2, 5, 8], [3, 6, 9], # cols
  [1, 5, 9], [3, 5, 7]             # diagonals
]
GAME_WINNING_SCORE = 5
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
SQUARE_FIVE = 5

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system "clear"
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(board, round)
  display_round_number(round)
  #puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |     "
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |     "
  puts ""
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def display_round_number(round)
  prompt "*** Round #{round} ***"
end

def display_first_player(player)
  prompt "#{player} is moving first!"
end

def display_score(scores)
  puts "#{'-'*20}"
  puts "#{"Scores:".center(20)}"
  prompt "Player: #{scores[:player]}"
  prompt "Computer: #{scores[:computer]}"
  prompt "Ties: #{scores[:ties]}"
  puts "#{'-'*20}"
end

def display_game_winner(scores)
  game_winner = detect_game_winner(scores)
  puts ""
  puts "***********************"
  prompt "#{game_winner} has reached #{GAME_WINNING_SCORE} points and has won the game!"
  prompt "Better luck next time!" if game_winner == 'Computer'
  puts "***********************"
end

def joinor(array, delimiter=", ", word="or")
  case array.size
  when 0 then ""
  when 1 then array.join
  when 2 then array.join(" #{word} ")
  else
    array[-1] = "#{word} #{array[-1]}"
    array.join(delimiter)
  end
end

def alternate_player(current_player)
  current_player == 'Player' ? 'Computer' : 'Player'
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  # board.keys returns an array of all keys in the board Hash
  # keys array.select returns a new array of all keys
  # where the value is an empty string (empty space)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def detect_at_risk_square(board, marker)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(marker) == 2
      line.each {|square| return square if board[square] == INITIAL_MARKER}
    end
  end
  nil
end

def detect_round_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).all?(PLAYER_MARKER)
      return 'Player'
    elsif board.values_at(*line).all?(COMPUTER_MARKER)
      return 'Computer'
    end
  end
  nil
end

def detect_game_winner(scores)
  if scores[:player] == GAME_WINNING_SCORE
    'Player'
  elsif scores[:computer] == GAME_WINNING_SCORE
    'Computer'
  end
end

def get_first_player
  player_one = nil
  loop do
    prompt "Who should go first? Enter a number:"
    prompt "1 - Me"
    prompt "2 - Computer"
    prompt "3 - Let the Computer choose!"

    player_one = gets.chomp

    break if ["1", "2", "3"].include?(player_one)

    prompt "Invalid answer. Enter 1 to go first, or 2 for the computer to go first."
  end
  
  case player_one
  when '1' then 'Player'
  when '2' then 'Computer'
  when '3' then ['Player', 'Computer'].sample
  end
end

def press_enter_to_start_round
  prompt "Press 'Enter' to start the next round:"
  gets.chomp
end

def update_scores(winner, scores) # could make this shorter if winner is passed in as a symbol, just scores[winner] += 1
  if winner == 'Player'
    scores[:player] += 1
  elsif winner == 'Computer'
    scores[:computer] += 1
  else
    scores[:ties] += 1
  end
end

def update_round(round)
  round + 1
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{joinor(empty_squares(board))}"
    square = gets.chomp.to_i

    break if empty_squares(board).include?(square)
    prompt "Sorry, that's not a valid choice."
  end

  board[square] = PLAYER_MARKER
end

def computer_places_piece!(board)
  square = nil

  if detect_at_risk_square(board, COMPUTER_MARKER) # offense
    square = detect_at_risk_square(board, COMPUTER_MARKER)
  elsif detect_at_risk_square(board, PLAYER_MARKER) # defense
    square = detect_at_risk_square(board, PLAYER_MARKER)
  elsif board[SQUARE_FIVE] == INITIAL_MARKER # choose square 5 if empty
    square = SQUARE_FIVE
  else # pick randomly
    square = empty_squares(board).sample
  end

  board[square] = COMPUTER_MARKER
end


def place_piece!(board, current_player)
  if current_player == 'Player'
    player_places_piece!(board)
  else
    computer_places_piece!(board)
  end
end

def board_full?(board)
  empty_squares(board).empty?
end

def round_won?(board)
  !!detect_round_winner(board)
end

def game_won?(scores)
  scores.reject {|k, _| k == :ties}.values.any? { |score| score == GAME_WINNING_SCORE }
end

def play_again?
  prompt "Play again? (y or n)"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

def play_round(board, round, scores, current_player) # here
  loop do # player and computer turns for one round
    clear_screen
    display_score(scores)
    display_board(board, round)
    prompt "#{current_player == 'Player'? 'Your' : "#{current_player}'s"} turn!"

    if current_player == 'Computer'
      prompt "Computer is choosing now..."
      sleep 1.2
    end

    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if round_won?(board) || board_full?(board)
  end

  clear_screen
  display_score(scores)
  display_board(board, round)

  if round_won?(board) # should this be its own helper method?
    round_winner = detect_round_winner(board)
    prompt "#{round_winner} wins this round!"
    update_scores(round_winner, scores)
    # display_score(scores)
    press_enter_to_start_round unless game_won?(scores)
  else
    prompt "It's a tie! No points are awarded."
    update_scores(:tie, scores)
    press_enter_to_start_round
  end
end

loop do # main game loop
  puts "Welcome to Tic Tac Toe!"
  puts "*** here are some rules placeholder ***"
  puts ""
  
  current_player = get_first_player
  display_first_player(current_player)
  sleep 2

  scores = { player: 0, computer: 0, ties: 0 }
  round = 1

  loop do # playing one whole round loop
    board = initialize_board

    play_round(board, round, scores, current_player)

    break if game_won?(scores)
  
    round = update_round(round)
  end

  display_game_winner(scores)

  break unless play_again?
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"