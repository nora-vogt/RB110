=begin
LEAP YEARS CONT'D

  - Gregorian Calendar adopted in 1752 (leap year)
  - Julian Calender used prior to 1752
    - leap years were any year evenly divisible by 4

# Update the previous method to account for this new information

input: integer (year)
output: boolean (true or false for leap year)

LEAP YEAR 1752 and BEYOND
  - evenly divisible by 400
  - not evenly divisible by 100
  - evenly divisible by 4

LEAP YEAR PRE-1752
  - evenly divisible by 4

=end


def leap_year?(year)
  if year % 400 == 0 && year >= 1752
    true
  elsif year % 100 == 0 && year >= 1752
    false
  else
    year % 4 == 0
  end
end

p leap_year?(2016) == true
p leap_year?(2015) == false
p leap_year?(2100) == false
p leap_year?(2400) == true
p leap_year?(240000) == true
p leap_year?(240001) == false
p leap_year?(2000) == true
p leap_year?(1900) == false
p leap_year?(1752) == true
p leap_year?(1700) == true
p leap_year?(1) == false
p leap_year?(100) == true
p leap_year?(400) == true