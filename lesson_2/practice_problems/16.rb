# A UUID is a type of identifier often used as a way to uniquely identify items...which may not all be created by the same system. That is, without any form of synchronization, two or more separate computer systems can create new items and label them with a UUID with no significant chance of stepping on each other's toes.

# It accomplishes this feat through massive randomization. The number of possible UUID values is approximately 3.4 X 10E38.

# Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.

# It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Write a method that returns one UUID when called with no parameters.

# Hexadecimal characters: numbers 0-9, letters A-F
# UUID has 32 hexidecimal characters
# UUID is broken into 5 sections, separated by hyphens (hyphens do not count as one of the 32 hexadecimal characters)
  # section 1: 8 chars
  # section 2: 4 chars
  # section 3: 4 chars
  # section 4: 4 chars
  # section 5: 12 chars
# method should return a string

# use Array#sample

# initialize a Constant to reference an array containing all possible hexadecimal characters
# create five variables to represent each section of the UUID (section_one, section_two, etc)
  # Randomly select the appropriate amount of characters from HEXADECIMAL_CHARS, assign the array to the section variable
      # section 1: 8 chars
    # section 2: 4 chars
    # section 3: 4 chars
    # section 4: 4 chars
    # section 5: 12 chars
  # convert the array into a string
# Once all 5 variables have been created and assigned, interpolate all 5 variables into a string, separated by hyphens

# First Attempt
# HEXADECIMAL_CHARS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f']

# def generate_uuid_section(number_of_chars)
#   HEXADECIMAL_CHARS.sample(number_of_chars).join('')
# end

# def generate_uuid
#   "#{generate_uuid_section(8)}-#{generate_uuid_section(4)}-#{generate_uuid_section(4)}-#{generate_uuid_section(4)}-#{generate_uuid_section(12)}"
# end

# Second attempt, after viewing LS solution - using iterative methods
def generate_uuid
  hexadecimal_chars = []
  (0..9).each {|int| hexadecimal_chars << int}
  ('a'..'f').each {|char| hexadecimal_chars << char}
  
  section_lengths = [8, 4, 4, 4, 12]
  uuid = ""

  section_lengths.each do |number|
    uuid << hexadecimal_chars.sample(number).join('')
    if number != 12
      uuid << '-'
    end
  end

  uuid
end


p generate_uuid
p generate_uuid