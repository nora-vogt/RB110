iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end

# Further Exploration
# If the break statement was moved up one line, we would need to change the condition to `iterations == 5`. Otherwise, the fifth iteration would execute, `iterations > 5` would evaluate as false (because iterations is equal to 5), and then `iterations += 1` would execute, incrementing the value of iterations to 6. this would result in the loop executing and printing output a 6th time, before breaking from the loop.