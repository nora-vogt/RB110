# Given the array below, turn this array into a hash where the names are the keys and the values are the positions in the array.

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]

# using #each_with_index - code is concise, easy to understand due to index block parameter

flintstones_hash = {}
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end

p flintstones_hash


# using #each_with_object - saves a line of code, because the method call creates the hash object; meaningful return value

flintstones_hash = flintstones.each_with_object({}) do |name, hash|
                      hash[name] = flintstones.index(name)
                    end

p flintstones_hash

# using #each
flintstones_hash = {}
flintstones.each do |name|
  flintstones_hash[name] = flintstones.index(name)
end

p flintstones_hash

