alphabet = 'abcdefghijklmnopqrstuvwxyz'
selected_chars = ''
counter = 0

loop do
  current_char = alphabet[counter]

  if current_char == 'g'  # selection criteria
    selected_chars << current_char  # appends current_char into the selected_chars string
  end

  counter += 1
  break if counter.size == alphabet.size
end

selected_chars # => "g"