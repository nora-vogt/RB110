require 'pry'
# Given the following data structure and without modifying the original array, use the map method to return a new array identical in structure to the original but where the value of each integer is incremented by 1.
  # return a new array
  # don't mutate original array
  # preserve original structure
  # increment each integer value by 1
  # array -> hashes -> hash values
    # notes: the #map block needs to return a hash object

result = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hash|
  hash.each_with_object({}) do |details, hash|
    hash[details[0]] = details[1] + 1
  end
end

p result

# The return value from map should be the following array:
p result == [{a: 2}, {b: 3, c: 4}, {d: 5, e: 6, f: 7}] # true


# LS Solution:
[{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}].map do |hsh|
  incremented_hash = {}
  hsh.each do |key, value|
    incremented_hash[key] = value + 1
  end
  incremented_hash
end
# => [{:a=>2}, {:b=>3, :c=>4}, {:d=>5, :e=>6, :f=>7}]