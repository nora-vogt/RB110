require 'pry'
# Write code that changes the array below so that all of the names are shortened to just the first three characters. Do not create a new array.

# Original solution: Using Array#map!
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |name| name = name[0..2] }
p flintstones

# LS Correction:
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Don't need the reassignment; elements are transformed based on return value of the block
flintstones.map! { |name| name[0..2] }
p flintstones


# Using a loop
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
counter = 0

loop do
  break if counter == flintstones.size

  flintstones[counter] = flintstones[counter][0, 3]
  # flintstones[counter] -> returns element in array at index position counter, a String -> String[0, 3] -> returns a new string -> the element at index position counter in the flintstones array is then assigned to the new string returned by String#[]

  counter += 1
end

p flintstones


# doesn't work:
#loop do
  # break if counter == flintstones.size

  # current_name = flintstones[counter]  
    # Assigning current_name to the object at index position counter in the flintstones array
    # current_name points to the same object that is at index position 0 in flintstones array


  # current_name = current_name[0, 3]
    # current_name[0, 3] is String#[], which returns a NEW STRING
    # current_name is then assigned to the new string
    # this only reassigns current_name, not the element at index position counter in the flintstones array

  # counter += 1
# end
