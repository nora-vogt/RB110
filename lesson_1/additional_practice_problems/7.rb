# Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"

# Example:
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

# Create an empty hash to store the frequency count

# Split the string into characters -> Array
# Remove strings containing only whitespace from array of characters
# Iterate through the array of characters
  # If the character already exists as a key in the hash, increment the value by 1
  # If the character does not exist as a key in the hash, create the key/value pair with the character as the key, and the value as Integer 1

frequency = {}
split_statement = statement.chars.reject! {|str| str == " "}

# split_statement.each do |char|
#   if frequency[char]
#     frequency[char] += 1
#   else
#     frequency[char] = 1
#   end
# end

# As a Ternary Statement
split_statement.each do |char|
  frequency[char] ? frequency[char] += 1 : frequency[char] = 1
end

p frequency

# LS Solution:
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a # creates an array of every upper and lower case letter

letters.each do |letter|
  letter_frequency = statement.count(letter)
  result[letter] = letter_frequency if letter_frequency > 0
end

p result

p result == frequency # => true; my hash has same value as LS solution

# The LS solution creates an array of all upper and lowercase letters, iterates over every letter, and on each iteration:
  # assigns letter_frequency to the total count (statement.count(letter)) of each letter in the given statement
  # if the letter_frequency has a value greater than 0:
    # creates a key in the hash for that letter (result[letter])
    # assigns letter_frequency as the value
  # if the letter_frequency has a value of zero (meaning the character was not present in the given statement), do nothing