# Determine the total age of just the male members of the family.

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# original
munster_details = munsters.values
total_age_males = 0

munster_details.each do |hash|
  if hash["gender"] == "male"
    total_age_males += hash["age"]
  end
end

p total_age_males

# LS Solution: use Hash#each_value