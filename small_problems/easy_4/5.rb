# Multiples of 3 and 5

=begin
# PROBLEM
  input: integer (greater than 1)
  output: integer (sum of multiples)

Rules:
- Find all multiples of 3 or 5 between 1 and the given integer
- Compute the sum of those numbers
- Given integer will always be greater than 1

-Qs
- what should numbers like 1 and 2 return? 0?

# EXAMPLES

multisum(3) == 3
3 => sum => 3

multisum(5) == 8
1 2 3 4 5
3 % 3 = 0
5 % 5 = 0

3 + 5 = 8

multisum(10) == 33
multisum(1000) == 234168

# DATA STRUCTURES
start: integer
middle: array to hold multiples
end: integer (sum)

# ALGORITHM
Given an integer, "number"
- Create variable "multiples" to reference an empty array
- Iterate through all numbers between 1 and the given "number"
  - Check if number is evenly divisible by 3 and 5 (to not double-add numbers like 15, a multiple of both 3 and 5)
    - if yes: add to  "multiples"
  - Check if number is evenly divisible by 5
    - if yes: add to  "multiples"
  - Check if number is evenly divisible by 3
    - if yes: add to  "multiples"
- sum the numbers in "multiples"
- return that sum
=end

def multisum(number)
  multiples = []
  (1..number).each do |int|
    if int % 3 == 0 && int % 5 == 0
      multiples << int
    elsif int % 5 == 0
      multiples << int
    elsif int % 3 == 0
      multiples << int
    end
  end
  multiples.sum
end

# LS Solution
def multiple?(number, divisor)
  number % divisor == 0
end

def multisum(max_value)
  sum = 0
  1.upto(max_value) do |number|
    if multiple?(number, 3) || multiple?(number, 5)
      sum += number
    end
  end
  sum
end

# Further Exploration - use #reduce (inject)
# def multisum(number)
#   (1..number).reduce(0) do |sum, n|
#     n % 3 == 0 || n % 5 == 0 ? sum + n : sum
#   end
# end

def multisum(number)
  # get the multiples then #inject to sum
  (1..number).select { |n| n % 3 == 0 || n % 5 == 0}.inject(:+)
end

p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168