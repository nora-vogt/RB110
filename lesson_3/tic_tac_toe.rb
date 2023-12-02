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

# rubocop:disable Metrics/MethodLength
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
# rubocop:enable Metrics/MethodLength

def display_introduction
  display_divider
  puts "Welcome to Tic-Tac-Toe!".center(DIVIDER_LENGTH)
  display_divider
  display_empty_line
  prompt "Would you like to see the rules of the game? Enter 'y' or 'n':"
  input = get_rules_display_choice

  if ['yes', 'y'].include?(input)
    display_rules
  elsif ['no', 'n'].include?(input)
    system "clear"
    prompt "Great, you already know the rules!"
    prompt "Get ready, you'll play until winner has 5 points."
    display_empty_line
  end
end

# rubocop:disable Metrics/AbcSize, Layout/LineLength
def display_board(board)
  display_empty_line
  puts "    1|    2|    3"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "    4|    5|    6"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "    7|    8|    9"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  puts "     |     |     "
  display_empty_line
end
# rubocop:enable Metrics/AbcSize, Layout/LineLength

def display_round_number(round)
  puts "**** Round #{round} ****"
end

def display_first_player(player)
  display_empty_line
  prompt "#{player} is moving first!"
  sleep 1.2
end

def display_whose_turn(current_player)
  prompt "#{current_player == 'Player' ? 'Your' : "Computer's"} turn!"
  if current_player == 'Computer'
    prompt "Computer is moving..."
    sleep 1
  end
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

def display_round_outcome(winner)
  display_divider
  if winner.nil?
    prompt "It's a tie! No points are awarded."
  else
    prompt "#{winner == 'Player' ? 'You win' : 'Computer wins'} this round!"
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
      line.each { |square| return square if board[square] == INITIAL_MARKER }
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

def get_rules_display_choice
  loop do
    input = gets.chomp.downcase
    return input if ['yes', 'y', 'no', 'n'].include?(input)
    prompt "Invalid choice. Enter 'y' or 'n':"
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
    square = gets.chomp
    break if valid_integer?(square) &&
             empty_squares(board).include?(square.to_i)
    prompt "Sorry, that's not a valid choice."
  end

  board[square.to_i] = PLAYER_MARKER
end

def computer_places_piece!(board)
  computer_square_to_win = detect_at_risk_square(board, COMPUTER_MARKER)
  player_square_to_win = detect_at_risk_square(board, PLAYER_MARKER)

  square = if computer_square_to_win # offense
             computer_square_to_win
           elsif player_square_to_win # defense
             player_square_to_win
           elsif board[SQUARE_FIVE] == INITIAL_MARKER # choose square 5
             SQUARE_FIVE
           else # pick randomly
             empty_squares(board).sample
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
  loop do
    display_game_information(board, scores, round)
    display_whose_turn(current_player)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)

    break if round_won?(board) || board_full?(board)
  end

  round_winner = detect_round_winner(board)
  update_scores(round_winner, scores)
  display_game_information(board, scores, round)
  display_round_outcome(round_winner)

  press_enter_to_start_next_round unless game_won?(scores)
end

def valid_integer?(string)
  string.to_i.to_s == string
end

def board_full?(board)
  empty_squares(board).empty?
end

def round_won?(board)
  !!detect_round_winner(board)
end

def game_won?(scores)
  scores_without_ties = scores.reject { |k, _| k == :ties }
  scores_without_ties.any? { |_, v| v == GAME_WINNING_SCORE }
end

def play_again?
  prompt "Play again? (y or n)"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

system "clear"
display_introduction

loop do
  current_player = get_first_player
  display_first_player(current_player)

  scores = { player: 0, computer: 0, ties: 0 }
  round = 1

  loop do
    board = initialize_board

    play_round(board, round, scores, current_player)

    break if game_won?(scores)

    current_player = alternate_player(current_player)
    round = update_round_number(round)
  end

  display_game_winner(scores)

  break unless play_again?
  system "clear"
end

prompt "Thanks for playing Tic-Tac-Toe! Goodbye!"
