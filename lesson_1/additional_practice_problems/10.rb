require 'pry'
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}


# Modify the hash such that each member of the Munster family has an additional "age_group" key that has one of three values describing the age group the family member is in (kid, adult, or senior). Your solution should produce the hash below:

# kid: 0-17, inclusive
# adult: 18-64, inclusive
# senior: 65+, inclusive


# munsters.each do |munster, details|
#   if details["age"] >= 65
#     details["age_group"] = "senior"
#   elsif details["age"] >= 18
#     details["age_group"] = "adult"
#   else
#     details["age_group"] = "kid"
#   end
# end



munsters.each do |munster, details|
  case details["age"]
  when (0..17)
    details["age_group"] = "kid"
  when (18..64)
    details["age_group"] = "adult"
  when (65..) # This syntax is an "endless range"
    details["age_group"] = "senior"
  end
end

p munsters

# LS Solution: could change the final 'when' to an 'else' statement