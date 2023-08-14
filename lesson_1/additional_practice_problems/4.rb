# Pick out the minimum age from our current Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }

# Using Hash#values + Array#min
p ages.values.min


# Using Hash#values + Hash#each
all_ages = ages.values
lowest_age = all_ages.shift

all_ages.each do |current_age|
  if current_age < lowest_age
    lowest_age = current_age
  end
end

p lowest_age
