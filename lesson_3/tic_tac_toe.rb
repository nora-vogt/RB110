require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # rows
  [1, 4, 7], [2, 5, 8], [3, 6, 9], # cols
  [1, 5, 9], [3, 5, 7]             # diagonals
]

def prompt(message)
  puts "=> #{message}"
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system "clear"

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
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |number| new_board[number] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  # board.keys => returns an array of all keys in board hash
  # [].select => returns an array of all keys whose values are an empty space
  board.keys.select { |number| board[number] == INITIAL_MARKER }
end

def joinor(array, delimiter=", ", word="or")
  case array.size
  when 0 then ""
  when 1 then array.join('')
  when 2 then array.join(" #{word} ")
  else
    array[-1] = "#{word} #{array[-1]}"
    array.join(delimiter)
  end
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    # * splat operator - passes all elements in line as arguments
    # if board.values_at(*line).count(PLAYER_MARKER) == 3
    #   return 'Player'
    # elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
    #   return 'Computer'
    # end
    if line.all? { |space| board[space] == PLAYER_MARKER }
      return 'Player'
    elsif line.all? { |space| board[space] == COMPUTER_MARKER }
      return 'Computer'
    end
  end

  nil
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
  square = empty_squares(board).sample
  # empty_squares => array of integers => sample returns an integer
  board[square] = COMPUTER_MARKER
end

def board_full?(board)
  empty_squares(board).empty?
  # board is full when there are no more empty squares =>
  # empty_squares will return an empty array
end

def someone_won?(board)
  !!detect_winner(board)
  # if player or computer wins, detect_winner returns a String. !!String => true
  # if there is no winner, detect_winner returns nil. !!nil => false
end

loop do
  board = initialize_board
  # board is a hash. key is space int, value is string - 'X' 'O' or ' '

  loop do
    display_board(board) # display the board

    player_places_piece!(board) # player makes move
    break if someone_won?(board) || board_full?(board)
    # check if someone won or board full

    computer_places_piece!(board) # computer makes move
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board) # display the board

  if someone_won?(board) # display winner or tie
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer == 'y'
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
