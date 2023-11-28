require 'pry'

DIVIDER_LENGTH = 30
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

def display_divider
  puts "*" * DIVIDER_LENGTH
end

def display_empty_line
  puts ""
end

def display_header(string)
  puts "---------#{string}---------"
end

def display_rules
  system "clear"
  display_header("Rules")
  puts <<~HEREDOC
    In Tic-Tac-Toe, you and the computer take turns marking squares on a board.
    In order to win, you need to mark three squares in a row either vertically,
    horizontally, or diagonally. The first player to successfully mark three
    squares in a row wins the round and gets one point. The round ends either
    when someone wins or the board is filled.

    The first player to reach five points wins the game.
    No points will be awarded for tie games.

    You may choose who moves first for the first round. Subsequent rounds will
    alternate which player moves first.

    Good luck!

  HEREDOC

  prompt "Press 'Enter' when you're ready to start the game!"
  gets.chomp
end

def display_introduction
  display_divider
  puts "Welcome to Tic-Tac-Toe!".center(DIVIDER_LENGTH)
  display_divider
  display_empty_line
  prompt "Would you like to see the rules of the game?"
  prompt "Enter 'yes' to see the rules or any other key to start playing:"
  input = gets.chomp.downcase

  if ['yes', 'y'].include?(input)
    display_rules
  else
    prompt "Great, you already know the rules!"
    prompt "Get ready, you'll play until winner has 5 points."
    display_empty_line
  end
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Layout/LineLength
def display_board(board)
  display_empty_line
  puts "    #{square_number(board, 1)}|    #{square_number(board, 2)}|    #{square_number(board, 3)}"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "    #{square_number(board, 4)}|    #{square_number(board, 5)}|    #{square_number(board, 6)}"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "    #{square_number(board, 7)}|    #{square_number(board, 8)}|    #{square_number(board, 9)}"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |     "
  display_empty_line
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Layout/LineLength

def square_number(board, num)
  board[num] == INITIAL_MARKER ? num : ' '
end

def display_round_number(round)
  puts "**** Round #{round} ****"
end

def display_first_player(player)
  display_empty_line
  prompt "#{player} is moving first!"
end

def display_score(scores)
  display_header("Scores")
  puts "Player: #{scores[:player]}"
  puts "Computer: #{scores[:computer]}"
  puts "Ties: #{scores[:ties]}"
  puts "-" * 24
end

def display_game_information(board, scores, round)
  system "clear"
  display_score(scores)
  display_round_number(round)
  display_board(board)
  prompt "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
end

def display_round_outcome(round_winner)
  display_divider
  if round_winner.nil?
    prompt "It's a tie! No points are awarded."
  else
    prompt "#{round_winner == 'Player' ? 'You win' : "Computer wins"} this round!"
  end
  display_divider
end

def display_game_winner(score)
  game_winner = detect_game_winner(score)
  display_empty_line
  display_divider
  prompt "#{GAME_WINNING_SCORE} points reached."
  if game_winner == 'Player'
    prompt "You win the game! Congratulations!"
  else
    prompt "Computer wins the game! Better luck next time."
  end
  display_divider
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

    prompt "Invalid choice. Enter 1, 2, or 3."
  end

  case player_one
  when '1' then 'Player'
  when '2' then 'Computer'
  when '3' then ['Player', 'Computer'].sample
  end
end

def press_enter_to_start_next_round
  prompt "Press 'Enter' to start the next round:"
  gets.chomp
end

def update_scores(winner, scores)
  if winner == 'Player'
    scores[:player] += 1
  elsif winner == 'Computer'
    scores[:computer] += 1
  else
    scores[:ties] += 1
  end
end

def update_round_number(round)
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

def play_round(board, round, scores, current_player)
  loop do # player and computer turns for one round
    display_game_information(board, scores, round)
    prompt "#{current_player == 'Player'? 'Your' : "#{current_player}'s"} turn!"
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if round_won?(board) || board_full?(board)
  end

  display_game_information(board, scores, round)
  round_winner = detect_round_winner(board)
  display_round_outcome(round_winner)
  update_scores(round_winner, scores)
  press_enter_to_start_next_round unless game_won?(scores)
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

system "clear"
display_introduction

loop do # main game loop
  current_player = get_first_player
  display_first_player(current_player)
  sleep 1.5

  scores = { player: 0, computer: 0, ties: 0 }
  round = 1

  loop do # playing rounds until the game is won
    board = initialize_board

    play_round(board, round, scores, current_player)

    if game_won?(scores)
      display_game_information(board, scores, round)
      display_game_winner(scores)
      break
    end

    current_player = alternate_player(current_player)
    round = update_round_number(round)
  end

  break unless play_again?
  system "clear"
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
