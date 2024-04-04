=begin
After Midnight (Part 2)

Write two methods that takes a time of day in 24-hr format ("hh:mm") and returns the number of minutes before and after midnight, respectively.

Input: string ("hh:mm")
Output: integer

Rules:
- Do not use Ruby's Date and Time classes
- make two methods - one calculating time after midnight, one before
- "00:00" and "24:00" both return 0 (midnight)
- Both methods should return a value in the range of 0..1439 (minutes in a day)
- Disregard daylight savings time and other time complications

EXAMPLES:
after_midnight('00:00') == 0
before_midnight('00:00') == 0
after_midnight('12:34') == 754
before_midnight('12:34') == 686
after_midnight('24:00') == 0
before_midnight('24:00') == 0

* after midnight * add to 0
"12:34"
hours = 12
minutes = 34

(hours * 60) + minutes = 754

"00:00"
hours: 0
minutes = 0

0 * 60 + 0 = 0

"24:00"
hours: 24
minutes: 0

24 * 60 + 0 = 1440 *Edge Case: if total is 1440, return 0

* before midnight * subtract from 1440
"00:00"
hours: 0
minutes: 0
0 * 60 + 0 = 0
1440 - 0 = 1440 *Edge Case, if total is 1440, return 0

"12:34"
hours: 12
minutes: 34
12 * 60 + 34 = 754
1440 - 754 = 686

"24:00"
hours: 24
minutes: 0
24 * 60 + 0 = 1440
1440 - 1440 = 0

* before midnight can use after midnight

DATA STRUCTURE:
start: string
middle: array of strings
middle: array of integers
end: integer

ALGORITHM:
Given a string, "time"

* convert_string_time_to_minutes
Given a string, "time"
- inialize "result" to an empty array
- split "time" into an array of integers ["hh", "mm"]
- iterate through array, and convert strings to integers
- return the 2-element array

* after_midnight *
- initialize MINUTES_PER_HOUR = 60
Given a string, "time"
- invoke convert_string_time_to_minutes, assign "hours", "minutes" to return value
- computer hours * 60 + minutes, assign to "minutes"
- check if result is 1440
  - if yes, return 0
  - if no, return "result"

* before_midnight*
- initialize MINUTES_PER_DAY = 1440
Given a string, "time"
- create "minutes", assign to return value of after_midnight(time)
- create "result", assign to calculation of MINUTES_PER_DAY - minutes
- check if result is 1440
  - if yes: return 0
  - if no: return result


=end
MINUTES_PER_HOUR = 60
MINUTES_PER_DAY = 1440

def convert_string_time_to_minutes(time)
  result = time.split(':')
  result.map { |unit| unit.to_i }
end

def after_midnight(time)
  hours, minutes = convert_string_time_to_minutes(time)
  minutes = hours * MINUTES_PER_HOUR + minutes
  minutes == MINUTES_PER_DAY ? 0 : minutes
end

def before_midnight(time)
  minutes = after_midnight(time)
  result = MINUTES_PER_DAY - minutes
  result == MINUTES_PER_DAY ? 0 : result
end

p after_midnight('00:00') == 0
p before_midnight('00:00') == 0
p after_midnight('12:34') == 754
p before_midnight('12:34') == 686
p after_midnight('24:00') == 0
p before_midnight('24:00') == 0

# Further Exploration