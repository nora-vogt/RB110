# PROBLEM
# Write a method that takes a year as input and returns the century. The return value should be a string that begins with the century number, and ends with st, nd, rd, or th as appropriate for that number.

# New centuries begin in years that end with 01. So, the years 1901-2000 comprise the 20th century.

  # Input: integer (year)
  # Output: string (century, ex: 20th)

  # Explicit Rules:
    # output will be a string that starts with century number plus appropriate suffix (st, d, rd, th)
    # new centuries begin in years that end in 01 (20th century is 1901 - 2000)
  # Implicit Rules:
    # centuries are 100 years

  # Qs
    # how should year zero be handled?

## EXAMPLES
# century(2000) == '20th'
# century(2001) == '21st'
# century(1965) == '20th'
# century(256) == '3rd'
# century(5) == '1st'
# century(10103) == '102nd'
# century(1052) == '11th'
# century(1127) == '12th'
# century(11201) == '113th'

# determine century
  # 2000 / 100 = 20 th
  # 2001 *ends in 1* 2001 / 200 + 1 = 21 st
  # 256 / 100 + 1 = 3rd
  # 5 / 100 = 0 + 1 = 1 st
  # 1127 / 100 + 1 = 12 th
  # 11201 / 100 + 1 = 13 th

  # pattern:
    # if year ends in 0, divide by 100 to get century year
    # any other year, divide by 100 and add 1 to get century year


# determine suffix: st, nd, rd, or th
  # century ends in:
    # 0 - th
    # 1 - st
    # 2 - nd
    # 3 - rd
    # 4 - th
    # 5 - th
    # 6 - th
    # 7 - th
    # 8 - th
    # 9 - th
    # 10-20 - th ** different pattern for centuries ending in a "teen" number

    # could do hash?

# DATA STRUCTURE
  # start: integer
  # middle: integer hash (keys: year, value: suffix pattern)
  # middle: array to hold integer + suffix
  # end: string

# ALGORITHM
# Given an integer ("year"),
  # create a constant "SUFFIXES" to hold key/value pairs of century endings and their appropriate suffix
  # create variable "century" to hold century number
  # create variable "suffix" to hold suffix

# ** determine_century_number method **
  # Determine if the integer ends in '0'
    # if yes: divide "year" / 100 and assign result to "century"
    # if no: divide ("year" / 100) and add 1, and assign result to "century"

# ** determine suffix method **
  # Get the suffix associated with "century"
    # create a variable "last_two_digits" to hold the last two digits of "century"
    # check if "last_two_digits" are between 11-19 (aka a "teen" number)
      # if yes: assign "th" to "suffix"
      # if no: look up last single digit of "century" key in SUFFIXES hash
        # assign value to "suffix"

  # convert "century" to a string and concatenate "suffix"
  # return "century"


SUFFIXES = { 0 => "th", 1 => "st", 2 => "nd", 3 => "rd",
            4 => "th", 5 => "th", 6 => "th", 7 => "th",
            8 => "th", 9 => "th"
} 

# FIRST SOLUTION
# def century(year)
#   if year.digits.first == 0 # digits returns an array of integers but in reverse
#     century = year / 100
#   else
#     century = (year / 100) + 1
#   end

  # last_two_digits = century.digits.reverse.first(2).join.to_i
  # if (11..19).include?(last_two_digits)
  #   suffix = "th"
  # else
  #   suffix = SUFFIXES[century.digits.first]
  # end

#   century.to_s + suffix
# end

# REFACTOR
def determine_century_year(year)
  if year.digits.first == 0 # digits returns an array of integers but in reverse
    year / 100
  else
    (year / 100) + 1
  end
end

def determine_suffix(century_number)
  last_two_digits = century_number.digits.reverse.first(2).join.to_i
  if (11..19).include?(last_two_digits)
    "th"
  else
    SUFFIXES[century_number.digits.first]
  end
end

def century(year)
  century = determine_century_year(year)
  suffix = determine_suffix(century)
  century.to_s + suffix
end

# LS Solution took the same approach, but used more math (%), and I just used the digits themselves - more work / maybe not as clear, but it works.
  # century value % 100 is 11, 12, 13 -> return 'th' for suffix
  # can also determine last digit by century % 10


p century(2000) == '20th'
p century(2001) == '21st'
p century(1965) == '20th'
p century(256) == '3rd'
p century(5) == '1st'
p century(10103) == '102nd'
p century(1052) == '11th'
p century(1127) == '12th'
p century(11201) == '113th'

#TIME: 28mins, 30s