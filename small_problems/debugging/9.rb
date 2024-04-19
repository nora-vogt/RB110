def valid_integer?(string)
  string.to_i.to_s == string
end

def guess_number(max_number, max_attempts)
  winning_number = (1..max_number).to_a.sample
  attempts = 0

  loop do
    attempts += 1
    break if attempts > max_attempts
    puts "target number is #{winning_number}"

    input = nil
    until valid_integer?(input)
      print 'Make a guess: '
      input = gets.chomp
    end

    guess = input.to_i

    if guess == winning_number
      puts 'Yes! You win.'
      #break
    else
      puts 'Nope. Too small.' if guess < winning_number
      puts 'Nope. Too big.'   if guess > winning_number

      # continue the loop if guess was incorrect
    end
  end
end

guess_number(10, 3)

=begin
Currently the use of recursion on line 28 by invoking `guess_number` within the loop is producing unexpected behavior. By invoking this method at the end of the loop when the user guesses incorrectly, a new `winning_number` is set and the number of `attempts` is reset.

To fix this, we need to remove this recursive invocation of `guess_number`. The `loop` method invoked on line 9 already contains all of the needed logic to prompt the user to continue guessing the winning number.

We also need to add another break statement after line 22, prompting us to break out of the guessing loop when the user correctly guesses the winning number. 
=end