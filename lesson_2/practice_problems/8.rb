# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |_, array|
  array.each do |string|
    string.chars.each do |char|
      puts char if "aeiouAEIOU".include?(char)
    end
  end
end

# LS Solution: initialize local variable "vowels" first. remember to use _ instead of key as we're not using the key block parameter. Could also have used Hash#each_value

# String#chars returns an array of characters