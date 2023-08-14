#In the array below, find the index of the first name that starts with "Be"

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Using Array#index
p flintstones.index { |name| name.start_with?("Be") }

# Using a loop
counter = 0
selected_index = nil
loop do
  break if counter == flintstones.size
  current_name = flintstones[counter]

  if current_name[0, 2] == "Be"
    selected_index = counter
    break
  end

  counter += 1
end

p selected_index


# LS Solution: Using Array#index with a block
