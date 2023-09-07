=begin
A continuation of the previous exercise.

The British Empire adopted the Gregorian Calendar in 1752, which was a leap year. Prior to 1752, the Julian Calendar was used. Under the Julian Calendar, leap years occur in any year that is evenly divisible by 4.

Using this information, update the method from the previous exercise to determine leap years both before and after 1752.

Problem------------------------
  Input:
    - An integer, representing a year

  Output:
    - A boolean, true if year is a leap year and false if it is not a leap year

  Explicit Rules:
    - Prior to 1752, a leap year is any year that is evenly divisible by 4
    - In and after 1752, a leap year is:
      - Any year that is evenly divisible by 400
      - Any year that is evenly divisible by 4 and NOT evenly divisible by 100
    - Input will be greater than 0

  Implicit Rules:
    - Only integers will be given as input

  Mental Model:
    Update the previous method for determing a leap year. If the year given is less than 1752, we only need to check if the year is evenly divisible by 4. If it is, it's a leap year. If it's not, it's not a leap year.

Examples--------------------
leap_year?(2016) == true
leap_year?(2015) == false
leap_year?(2100) == false
leap_year?(2400) == true
leap_year?(240000) == true
leap_year?(240001) == false
leap_year?(2000) == true
leap_year?(1900) == false
leap_year?(1752) == true
leap_year?(1700) == true # this changed to true
leap_year?(1) == false
leap_year?(100) == true # this changed to false 
leap_year?(400) == true


Data Structure--------------
No data structure needed


Algorithm-----------------
  1. Add another condition to the if statement
    a. check if the year is less than 1752 and evenly divisible by 4
      - if yes, return true
=end


def leap_year?(year)
  if year < 1752 && year % 4 == 0
    true
  elsif year % 400 == 0 # definitely a leap year
    true
  elsif year % 100 == 0 # if divisible by 100, only a leap year if also divisible by 400 - covered in the first condition
    false
  else
    year % 4 == 0 # if the year is not divisible by 100 (elsif condition), and if divisible by 4, then it is a leap year.
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