# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# First solution: using Hash#values and Array#sum
total_age = ages.values.sum
p total_age


# Using Hash#each
total_age = 0
ages.each do |_, age|
  total_age += age
end

p total_age

# Using Hash#each_value
total_age = 0
ages.each_value {|age| total_age += age}

p total_age

# Using a loop
munsters = ages.keys
counter = 0
total_age = 0

loop do
  break if counter == munsters.size
  current_munster = munsters[counter]
  total_age += ages[current_munster]

  counter += 1
end

p total_age


# LS Solution::
p ages.values.inject(:+)