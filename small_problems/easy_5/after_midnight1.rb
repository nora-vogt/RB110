require 'Time'
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
goal: get rid of minutes beyond 0-1439
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

# MINUTES_PER_HOUR = 60
# MINUTES_PER_DAY = 1440

# def normalize_minutes(minutes)
#   minutes.divmod(MINUTES_PER_DAY)[1]
# end

# def time_of_day(minutes)
#   minutes = normalize_minutes(minutes)
#   hours, minutes = minutes.divmod(MINUTES_PER_HOUR)
#   format('%02d:%02d', hours, minutes)
# end

# LS Solution
MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

# def normalize_minutes_to_0_through_1439(minutes)
#   while minutes < 0
#     minutes += MINUTES_PER_DAY
#   end

#   minutes % MINUTES_PER_DAY
# end

# def time_of_day(delta_minutes)
#   delta_minutes = normalize_minutes_to_0_through_1439(delta_minutes)
#   hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
#   format('%02d:%02d', hours, minutes)
# end

# Further Exploration 1
# def normalize_minutes_to_0_through_1439(minutes)
#   minutes % 1440
# end
# this returns the same result as my original solution: minutes.divmod(MINUTES_PER_DAY)[1]

# def time_of_day(delta_minutes)
#   delta_minutes = normalize_minutes_to_0_through_1439(delta_minutes)
#   hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
#   format('%02d:%02d', hours, minutes)
# end

# Further Exploration 2
# How would you approach this problem if you were allowed to use ruby's Date and Time classes?

# Time.new(0) makes a new Time object with date 0000-01-01, time 00:00:00
   # so we can add seconds to this object

# strftime
  # '%H:%M' gives 24 hr time, equivalent to '%R'

# SECONDS_PER_MINUTE = 60
# def time_of_day(minutes)
#   (Time.new(0) + minutes * SECONDS_PER_MINUTE).strftime('%R')
# end

# Further Exploration 3
  # allowed to use Date and Time, consider day of week
  # assume delta_minutes is the number of minutes before/after the midnight between Saturday and Sunday
  # ex: delta_minutes value of -4231 would need to produce a return value of Thursday 01:29

  # 0 -> 00:00 on Sunday  

SECONDS_PER_MINUTE = 60

def time_of_day(minutes)
  (Time.new(2023, 11, 5) + minutes * SECONDS_PER_MINUTE).strftime('%A %R')
end


p time_of_day(0) #== "00:00"
p time_of_day(-3) #== "23:57"
p time_of_day(35) #== "00:35"
p time_of_day(-1437) #== "00:03"
p time_of_day(3000) #== "02:00"
p time_of_day(800) #== "13:20"
p time_of_day(-4231) #== "01:29"
