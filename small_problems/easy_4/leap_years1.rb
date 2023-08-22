=begin
In the modern era under the Gregorian Calendar, leap years occur in every year that is evenly divisible by 4, unless the year is also divisible by 100. If the year is evenly divisible by 100, then it is not a leap year unless the year is evenly divisible by 400.

Assume this rule is good for any year greater than year 0. Write a method that takes any year greater than 0 as input, and returns true if the year is a leap year, or false if it is not a leap year.

Problem:
  Inputs:
    - an Integer, greater than 0 (representing the year)
  Outputs:
    - a Boolean (true if input is leap year, otherwise false if not a leap year)

  Explicit Rules:
    - A leap year is defined as:
      - A year that is evenly divisible by 4, UNLESS:
        - the year is also divisible by 100, IF SO:
          - only a leap year if it is evenly divisible by 400
    - Input must be an integer greater than 0

  Implicit Rules:
    - A year that can be evenly dividied by 400 can also be evenly divided by 100 and 4, making it a leap year

  Mental Model:
    Define a method that determines if a given number greater than 0 is a leap year. A year is a leap year only if it is:
      - Divisible by 4 AND not evenly divisible by 100, OR
      - Divisible by 4 AND evenly divisible by 100 AND evenly divisible by 400

Examples:
  leap_year?(2016) == true
    2016 % 4 == 0? # => true
    2016 % 100 == 0 # => false


  leap_year?(2015) == false
    2016 % 4 == 0 # => false

  leap_year?(2100) == false
  leap_year?(2400) == true
    2400 % 4 == 0 # true
    2400 % 100 == 0 # true
    2400 % 400 == 0 # true


  leap_year?(240000) == true
  leap_year?(240001) == false
  leap_year?(2000) == true
  leap_year?(1900) == false
  leap_year?(1752) == true
  leap_year?(1700) == false
  leap_year?(1) == false
  leap_year?(100) == false
  leap_year?(400) == true

Data Structure
- integer

Algorithm:
Given an integer greater than 0,
  1. Check if integer is evenly divisible by 4
    a. if not -> not a leap year -> return false
    b. if yes:
      1. Check if integer is evenly divisible by 100
        a. if not -> is a leap year -> return true
        b. if yes:
          1. Check if integer is evenly divisible by 400
            a. if not -> not a leap year -> return false
            b. if yes -> is a leap year -> return true


Code:
=end

# Divisible by 4 AND not evenly divisible by 100, OR
# Divisible by 4 AND evenly divisible by 100 AND evenly divisible by 400

def leap_year?(year)
  if year % 400 == 0
    true
  elsif (year % 4 == 0) && (year % 100 != 0)
    true
  else
    false
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
p leap_year?(1700) == false
p leap_year?(1) == false
p leap_year?(100) == false
p leap_year?(400) == true