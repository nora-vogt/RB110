require 'pry'
=begin
After Midnight (Part 1)

PROBLEM
Write a method that takes an integer, representing the number of minutes before or after midnight, and returns the time of day as a string in 24 hour format "hh:mm".

Input: 
- integer (positive, negative, or zero)
Output:
- string "hh:mm"

Rules:
- The given integer represents the number of minutes either before or after midnight
- Given 0, that is midnight "00:00"
- A negative number means time is before midnight (midnight (0) - # of minutes)
- A positive number means time is after midnight (midnight (0) + number of minutes)
- Do not use Ruby's Date or Time class
- Integer may begin with a negative sign
- Disregard Daylight Savings and other time complications

- Number of minutes in day: 1440
- midnight is both 0 and 1440?

- for minutes > 1440 or < -1440, can standardize to a 24-hr day

EXAMPLES:
time_of_day(0) == "00:00"


time_of_day(-3) == "23:57"
sign: negative
start: 1440
1440 - 3 = 1437.divmod(60) => [23, 57] => "23:57"

-3.divmod(1440) => [-1, 1437], take the second, 1437
1437.divmod(60) => [23, 57] => "23:57"

time_of_day(35) == "00:35"
time_of_day(-1437) == "00:03"
time_of_day(3000) == "02:00"
3000.divmod(1440) = [2, 120] => take the second, 120

start: 120
120.divmod(60) => [2, 0] => "02:00"

time_of_day(800) == "13:20"
time_of_day(-4231) == "01:29"
*standardize day*
-4231.divmod(1440) => [-3, 89] => 3 days, 89 minutes 
minutes now positive

sign: positive
start: 89.divmod(60) => [1, 29] => "01:29"



DATA STRUCTURE:
start: integer (pos, neg, or 0)

ALGORITHM:
Given an integer,

* standardize time to 1 day * "standardize_time"
Given an integer,
- Divide the integer by 1440 (mins in a day), get the quotient and remainder
- discard the quotient
- return the remainder (# of mins)

* time_of_day *
- create variable "total_minutes" and assign to return value of invoking standardize_time, passing in "integer"
- divide "total_minutes" by 60, getting the quotient and remainder
- assign "hours" to quotient and "minutes" to remainder
- invoke format_time, return return value

* format time *
- Given two integers, "hours", "minutes"
- convert hours and minutes to string
- concatenate hours + string
- format so that there are two digits in both hours and minutes place - leading 0 may be necessary  "01:30"
=end

# def standardize_time(integer) # could refactor this to just use %
#   days, minutes = integer.divmod(1440)
#   minutes
# end

# def format_time(hours, minutes)
#   hours = hours.to_s
#   minutes = minutes.to_s
#   hours.prepend('0') if hours.size == 1
#   minutes.prepend('0') if minutes.size == 1
#   "#{hours}:#{minutes}"
# end

# def time_of_day(integer)
#   total_minutes = standardize_time(integer)
#   hours, minutes = total_minutes.divmod(60)
#   format_time(hours, minutes)
# end

# p time_of_day(0) == "00:00"
# p time_of_day(-3) == "23:57"
# p time_of_day(35) == "00:35"
# p time_of_day(-1437) == "00:03"
# p time_of_day(3000) == "02:00"
# p time_of_day(800) == "13:20"
# p time_of_day(-4231) == "01:29"

# TIME: 22:20

=begin
LS Solution:
Given an integer, "delta_minutes"
- initialize MINUTES_PER_HOUR assign to 60
- initialize HOURS_PER_DAY assign to 24
- initialize MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR
- Normalize the given integer, so that the number of minutes will fall in the range of 0-1439 (the number of minutes in a day) ** see normalize minutes
- Reassign delta_minutes to return value of normalize_minutes...
- Initialize "hours", "minutes"
- divide "delta_minutes" by 60, getting quotient and remainder
- assign "hours" to quotient and "minutes" to remainder
- Convert "hours" and "minutes" into a string, formatted to "hh:mm"

* normalize minutes * normalize_minutes_to_0_through_1439
- Given an integer, "minutes" (number of minutes, positive or negative or 0)
- Start a loop
  - If minutes is less than 0 (negative)
  - reassign minutes to minutes + MINUTES_PER_DAY
  - break out of loop when minutes >= 0
- Now we have the number of minutes after midnight (positive)
- Divide minutes by MINUTES_PER_DAY and return the remainder
=end

MINUTES_PER_HOUR = 60
HOURS_PER_DAY = 24
MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR

def normalize_minutes_to_0_through_1439(minutes)
  while minutes < 0
    minutes += MINUTES_PER_DAY
  end

  minutes % MINUTES_PER_DAY
end

def time_of_day(delta_minutes)
  delta_minutes = normalize_minutes_to_0_through_1439(delta_minutes)
  hours, minutes = delta_minutes.divmod(MINUTES_PER_HOUR)
  format('%02d:%02d', hours, minutes)
end

# p time_of_day(0) == "00:00"
# p time_of_day(-3) == "23:57"
# p time_of_day(35) == "00:35"
# p time_of_day(-1437) == "00:03"
# p time_of_day(3000) == "02:00"
# p time_of_day(800) == "13:20"
# p time_of_day(-4231) == "01:29"

# Futher Exploration
# Problem 1
# Write a single-line normalization that uses %

def normalize_with_modulo(minutes)
  minutes % MINUTES_PER_DAY
end

# p normalize_with_modulo(-1437) == 3
# p normalize_with_modulo(0) == 0
# p normalize_with_modulo(3000) == 120
# p normalize_with_modulo(-4231) == 89
# p normalize_with_modulo(35) == 35

# Problem 2 - use Date and Time classes
