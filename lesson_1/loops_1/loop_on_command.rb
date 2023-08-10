loop do
  puts 'Should I stop looping?'
  answer = gets.chomp

  break if answer == 'yes'
  puts "Wrong answer. I'm looping again!"
end