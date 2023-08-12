def select_letter(sentence, character)
  selected_characters = ''
  counter = 0

  loop do
    break if counter == sentence.length
    current_char = sentence[counter]

    if current_char == character
      selected_characters << current_char
    end

    counter += 1
  end

  selected_characters
end


question = 'How many times does a particular character appear in this sentence?'
p select_letter(question, 'a') # => "aaaaaaaa"
p select_letter(question, 't') # => "ttttt"
p select_letter(question, 'z') # => ""

p select_letter(question, 'a').size # => 8
p select_letter(question, 't').size # => 5
p select_letter(question, 'z').size # => 0