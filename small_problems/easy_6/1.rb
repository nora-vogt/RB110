=begin
Cute Angles

Input:
- an Integer or Float between 0 - 360 (represents angle)

Output:
- a string (degrees, minutes, seconds)

Rules:
- ° to represent degrees
- ' single quote to represent minutes
- " double quote to represent seconds
- Format is degree°minute'seconds" - no spaces
- seconds double quote " may need to be escaped, depending on how output string is formatted
- A degree has 60 minutes
- A minute has 60 seconds
- Use 2-digit numbers with leading zeroes while formatting minutes and seconds
- Will have to normalize minutes/seconds (max minutes/seconds is 59)

EXAMPLES:
puts dms(30) == %(30°00'00")

30
30 = 30 degrees
30 * 60 = 1800 minutes
  normalize minutes: 1800 % 60 = 0
1800 * 60 = 108000 seconds
  normalize seconds: 108000 % 60 = 0

30, 0, 0 -> format -> 30°00'00"


puts dms(76.73) == %(76°43'48")

76.73 = 76 degrees (round down to whole number?)
76.73 * 60 = 4603.8
normalize minutes: 4603.8 % 60 = 43.80000000000018 
  * conver to integer to round down  -> 43
43.80000000000018 * 60 = 48.000000000010914  seconds
  * conver to integer to round down  * -> 48

76, 43, 48 -> format -> 76°43'48"


puts dms(254.6) == %(254°36'00")
  - round down to whole number

puts dms(93.034773) == %(93°02'05")

puts dms(0) == %(0°00'00")

puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")
360
360 = 360 degrees
360 * 60 = 21600 minutes
  * normalize minutes * 21600 % 60 = 0
21600 * 60 = 1296000 seconds
  * normalize seconds * 1296000 % 60 = 0

  360, 0, 0 -> format -> 360°00'00"

DATA STRUCTURE:
- start: float or integer
- middle: array of degree - minutes - seconds
- output: formatted string

ALGORITHM:
Given a Float or Integer, "number"
- initialize "minutes"
- initialize "seconds"
- initialize "values", assign to empty array
- calculate the minutes
  - number * 60
  - assign to "minutes"
- calculate the seconds
  - minutes * 60
  - assign to "seconds"
- normalize degrees, add to "values" ** helper method
- normalize minutes, add to "values" ** helper method
- normalize seconds, add to "values" ** helper method
- convert value in values to a string** helper method
  - iterate through values, return the string version of integer
- format values
  - add a degree sign to end of degrees
  - format minutes and seconds to "OO" format (2-digt number)
- join formatted values into a string

* normalize degrees *
Given a number, "number"
  - convert number to an Integer (will round down)
  - return that number

* normalize minutes or seconds*
Given a number, "number"
  - calculate number modulus 60
  - convert value to integer to round down
  - return that integer

=end
SIXTY = 60
DEGREE = "\xC2\xB0"

def normalize_degrees(number)
  number.to_i
end

def normalize_minutes_or_seconds(number)
  (number % SIXTY).to_i
end

def calculate_values(number)
  degrees = normalize_degrees(number)
  minutes = normalize_minutes_or_seconds(number * SIXTY)
  seconds = normalize_minutes_or_seconds(number * SIXTY * SIXTY)
  [degrees, minutes, seconds]
end

def format_min_or_sec(string)
  format('%02d', string)
end

def convert_values_to_string(array)
  ["#{array[0]}#{DEGREE}", "#{format_min_or_sec(array[1])}'", "#{format_min_or_sec(array[2])}\""]
end

def dms(number)
  values = calculate_values(number)
  string_values = convert_values_to_string(values)
  string_values.join
end

# All test cases should return true
puts dms(30) == %(30°00'00")
puts dms(76.73) == %(76°43'48")
puts dms(254.6) == %(254°36'00")
puts dms(93.034773) == %(93°02'05")
puts dms(0) == %(0°00'00")
puts dms(360) == %(360°00'00") || dms(360) == %(0°00'00")

# TIME: 40