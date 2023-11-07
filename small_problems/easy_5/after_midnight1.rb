=begin
Write a method that takes a time using this minute-based format and returns the time of day in 24 hour format (hh:mm). Your method should work with any integer input.

You may not use ruby's Date and Time classes.

# P
  Explicit Rules:
  - If given number of minutes is positive -> time is AFTER midnight
  - If given number of minutes is negative -> time is BEFORE midnight
  - 24 hours in a day
  - Do not use Ruby's Date and Time class
  - any Integer may be given as input
  - Return the time of day in hh:mm format

  Implicit Rules:
  - there are 1440 minutes in a day
  - minute 0 is Midnight
  - given values may be greater than 1440 or less than -1440
  - Output should be a String ->  "hh:mm"

# E
time_of_day(0) == "00:00"
1440 - 0 = 1400.divmod(60) -> [24, 0] -> "00:00"


time_of_day(-3) == "23:57"
1440 - 3 = 1437.divmod(60) -> [23, 57] -> "23:57"


time_of_day(35) == "00:35"
35.divmod(60) -> [0, 35] -> 00:35

time_of_day(-1437) == "00:03"
1440 - 1437 = 3.divmod(60) -> [0, 3] -> "00:03"

time_of_day(800) == "13:20"
800.divmod(60) -> [13, 20] -> "13:20"

time_of_day(3000) == "02:00"
3000.divmod(1440) -> [2, 120] -> 2 days, 120 mins. take the remainder
120.divmod(60) -> [2, 0] -> "02:00"


time_of_day(-4231) == "01:29"
-4231.divmod(1440) -> [-3, 89]
89.divmod(60) -> [1, 29] -> "01:29"


NOTES: need to standardize the time for values greater than 1440 or less than -1440; divide them by 1440?



# D 
start: integer
middle: array, to hold hours/minutes
end: formatted string

# A
** if Input is negative, subtract from 1400 before dividing**
** if input is positive, can jump to dividing**
** for nums greater than 1440 / less than -1440, divide by 1440 to get the days, then take the remainder (minutes) -> proceed to step 2 (divide by 60)

** Standardize Minutes - helper method**
Given an integer greater than 1440 or less than -1440
  - Divide by 1400, get the remainder
  - The remainder is minutes, return the minutes

** Main method **
- Given a standardized positive integer, "minutes" 
- reassign "minutes" to the output of the "normalize_minutes" helper method

  - Divide "minutes" by 60, get the quotient and the remainder, store in array "output"

  - Convert the "output" array into a string with "hh:mm" formatting
    - use the value at index 0 as the hour
    - use the value at index 1 as the minutes

# C
=end

MINUTES_PER_HOUR = 60
MINUTES_PER_DAY = 1440

def normalize_minutes(minutes)
  minutes.divmod(MINUTES_PER_DAY)[1]
end

def time_of_day(minutes)
  minutes = normalize_minutes(minutes)
  hours, minutes = minutes.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, minutes)
end

p time_of_day(0) == "00:00"
p time_of_day(-3) == "23:57"
p time_of_day(35) == "00:35"
p time_of_day(-1437) == "00:03"
p time_of_day(3000) == "02:00"
p time_of_day(800) == "13:20"
p time_of_day(-4231) == "01:29"