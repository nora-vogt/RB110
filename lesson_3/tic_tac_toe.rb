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

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(board, round)
  system "clear"

  prompt "*** Round #{round} ***"
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
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

def display_scores(scores)
  prompt "*** The score is ***"
  prompt "Player: #{scores[:player]}, Computer: #{scores[:computer]}"
end

def display_game_winner(game_winner)
  puts ""
  puts "***********************"
  prompt "#{game_winner} has reached #{GAME_WINNING_SCORE} points and has won the game!"
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

def detect_at_risk_square(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 2
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
  if scores[:player] == 5
    'Player'
  elsif scores[:computer] == 5
    'Computer'
  end
end

def update_scores(winner, scores) # could make this shorter if winner is passed in as a symbol, just scores[winner] += 1
  if winner == 'Player'
    scores[:player] += 1
  elsif winner == 'Computer'
    scores[:computer] += 1
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
  if detect_at_risk_square(board)
    board[detect_at_risk_square(board)] = COMPUTER_MARKER
  else
    random_square = empty_squares(board).sample
    board[random_square] = COMPUTER_MARKER
  end
end

def board_full?(board)
  empty_squares(board).empty?
end

def round_won?(board)
  !!detect_round_winner(board)
end

def game_won?(scores)
  scores.values.any? { |score| score == GAME_WINNING_SCORE }
end

def play_again?
  prompt "Play again? (y or n)"
  answer = gets.chomp.downcase
  ['y', 'yes'].include?(answer)
end

def play_round(board, round_number, scores)
  loop do # player and computer turns for one round
    display_board(board, round_number)
    player_places_piece!(board)
    break if round_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if round_won?(board) || board_full?(board)
  end

  display_board(board, round_number)

  if round_won?(board) # should this be its own helper method?
    round_winner = detect_round_winner(board)
    prompt "#{round_winner} wins this round!"
    update_scores(round_winner, scores)
    display_scores(scores)
  else
    prompt "It's a tie! No points are awarded."
  end
end

loop do # main game loop
  scores = { player: 0, computer: 0 } # consider moving the round to here, changing var name to "scoreboard"
  round = 1

  loop do # playing one whole round loop
    board = initialize_board

    play_round(board, round, scores)

    if game_won?(scores)
      game_winner = detect_game_winner(scores)
      display_game_winner(game_winner)
      break
    end

    round = update_round_number(round)
  end

  break unless play_again?
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
