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