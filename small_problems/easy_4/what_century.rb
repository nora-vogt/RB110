=begin
Write a method that takes a year as input and returns the century. The return value should be a string that begins with the century number, and ends with st, nd, rd, or th as appropriate for that number.

New centuries begin in years that end with 01. So, the years 1901-2000 comprise the 20th century.
=end



=begin
--- P
Input: integer (represents the year)
Output: a string that consists of an integer and ending in 'st', 'nd', 'rd', or 'th'

Explicit Rules:

- Every century begins in years that end with 01
- Output string must begin with century and end with suffix

Implicit Rules:
- A centuary is 100 years


Questions:
- What should happen if zero is entered? 

--- E
p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'

Modeling:

5 -> '1st'
5 / 100 -> 0 + 1 => 1

2000 -> '20th'
2000 / 100 -> 20

1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th
101st 102nd 103rd 104th 105th 106th 107th 109th 109th 200th

century ending in 1: st
century ending in 2: nd
century ending in 3: rd
century ending in 4..10: th
century ending in 11..13: th


--- D
start: an integer
middle: integer -> convert to string
end: a string

--- A

Given an integer:

1. Create a variable "integer_to_century"
2. Check if the integer is evenly divisible by 100
  a. If yes -> return the quotient
  b. If no -> return the quotient + 1
  c. Assign return value to integer_to_century
3. Convert the integer to a string
4. Check the last two digits of the integer and appending the appropriate suffix
  a.  century ending in 11..13: th *checking edge case first*
  Check the last digit of the integer and append the appropriate suffix
  a. If century ending in 1: st
  b.  century ending in 2: nd
  c.  century ending in 3: rd
  d.  century ending in 4..10: th
5. Return the string
=end

def century(number)
  integer_to_century = nil

  if number % 100 == 0
    integer_to_century = number / 100
  else
    integer_to_century = (number / 100) + 1
  end

  integer_to_century = integer_to_century.to_s

  if ('11'..'13').include?(integer_to_century[-2, 2])
    integer_to_century << "th"
  else
    case integer_to_century[-1]
      when "1"
        integer_to_century << "st"
      when "2"
        integer_to_century << "nd"
      when "3"
        integer_to_century << "rd"
      else 
        integer_to_century << "th"
    end
  end

  integer_to_century
end

p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'