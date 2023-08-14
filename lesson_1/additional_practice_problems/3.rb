# In the ages hash, remove people with age 100 and greater.

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# Using Hash#delete_if
# ages.delete_if {|_, age| age >= 100}
# p ages


# Using Hash#reject!
# ages.reject! {|_, age| age >= 100}
# p ages

# Using Hash#keep_if
# ages.keep_if {|_, age| age < 100}
# p ages

# Using Hash#select!
ages.select! {|_, age| age < 100}
p ages