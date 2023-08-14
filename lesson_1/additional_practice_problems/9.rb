# Write your own version of the rails titelize implementation:

# words = "the flintstones rock"
# words = "The Flintstones Rock"

# Given a string:
  # Split the string on spaces
  # Store the splits in an array
  # Iterate through the array:
    # Capitalize each substring (mutating)
  # After iterating, join the array elements back into a string
  # Return the string
  
def titelize(string)
  string_words = string.split
  string_words.map! { |word| word.capitalize }
  string_words.join(' ')
end

p titelize("the flintstones rock")


# LS SOLUTION: use method chaining - this can be one line!
# def titelize(string)
#   string.split.map { |word| word.capitalize }.join(' ')
# end

# p titelize("the flintstones rock")