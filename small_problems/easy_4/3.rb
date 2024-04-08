=begin
# PROBLEM
  Input: integer (year)
  output: boolean (true if leap year, false if not)

  Rules:
  - A leap year occurs in
    - every year that IS evenly divisible by 4 and NOT evenly divisible by 100
    - IF the year is evenly divisible by 100, must also be evenly divisible by 400

A leap year is every year evenly divisible by 4 and not evenly divisible by 100. A leap year can also be evenly divisble by 100 if it is also evenly divisible by 400. 

  - Input will be greater than the year 0

# EXAMPLES
leap_year?(2016) == true

2016 % 4 == 0 && 2016 % 100 == 17 => LEAP YEAR TRUE


leap_year?(2015) == false
leap_year?(2100) == false
2100 % 4 == 0
2100 % 100 == 0
2100 % 400 == 100 => NOT A LEAP YEAR FALSE

leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == false
leap_year?(1) == false
leap_year?(100) == false

leap_year?(400) == true
400 % 400 = 0
400 % 100 = 0
400 % 4 = 0

# DATA STRUCTURE
start: integer
middle: integer
end: boolean

# ALGO
Given an integer "year",
  - Check if the year is evenly divisible by 4, and not evenly divisible by 100
    - if yes: return true
    - if no: continue
  - check if the year is evenly divisible by 100 and evenly divisible by 400
    - if yes: return true
    - if no: return false
=end

# def leap_year?(year)
#   if year % 4 == 0 && year % 100 != 0
#     true
#   elsif year % 400 == 0 # if a year is evenly divisible by 400, it is also evenly divisible by 100 and 4
#     true
#   else
#     false
#   end
# end

# LS Solution
# def leap_year?(year)
#   if year % 400 == 0
#     true
#   elsif year % 100 == 0
#     false
#   else
#     year % 4 == 0
#   end
# end

# Further Exploration
# def leap_year?(year)
#   if year % 100 == 0
#     false
#   elsif year % 400 == 0
#     true
#   else
#     year % 4 == 0
#   end
# end

# If we write theh solution as shown above, the solution will fail for leap years that are not evenly divisible by 100 but are evenly divisible by 4, because the condition to check if year % 100 == 0 appears first following the if branch, the method will return false and be unable to continue to check if the year is evenly divisible by 4.

def leap_year?(year)
  if year % 4 == 0
    true
  elsif year % 100 == 0
    false
  else
    year % 400 == 0
  end
end
# We cannot flip the order of the solution and write it this way. 


p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == false
p leap_year?(1) == false
p leap_year?(100) == false
p leap_year?(400) == true
# TIME: 10 mins