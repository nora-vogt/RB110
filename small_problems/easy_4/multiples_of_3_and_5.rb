=begin
Write a method that searches for all multiples of 3 or 5 that lie between 1 and some other number, and then computes the sum of those multiples. For instance, if the supplied number is 20, the result should be 98 (3 + 5 + 6 + 9 + 10 + 12 + 15 + 18 + 20).

You may assume that the number passed in is an integer greater than 1.

PROBLEM:
Input:
  - An integer greater than 1

Output:
  - An integer, the sum of all multiples of 3 and 5 between 1 and input

Explicit Rules:
  - Multiples must be of 3 or 5
  - Multiples must be between 1 and the provided input integer
  - To compute the sum of the multiples, add them together 
  - The input number will be an integer greater than 1

Implicit Rules:
  - Some numbers will be multiples of 3 and 5 (ex: 15)
  - A number has a multiple of 3 or 5 if it can be evenly divisible by 3 or 5


Questions:
  - What is a multiple?
    A multiple is a product that is obtained when one number is multipled by another number. AKA: To get the number, its multiple can be multipled by another number. 3 * 2 = 6 - both three and two are multiples of six.

Mental Model: 
  Given an integer greater than one, check all integers between 1 and the input. If the number is evenly divisible by 3 or 5, add that number to the sum of multiples. Finally, return the sum of multiples.


EXAMPLES:
p multisum(3) == 3
p multisum(5) == 8
p multisum(10) == 33
p multisum(1000) == 234168

multisum(3) == 3
1 2 3
=> 3


multisum(10) == 33
1 2 3 4 5 6 7 8 9 10

3 + 5 + 6 + 9 + 10 = 33
=> 33

Data Structure:
- None required
- Use an integer for the sum

Algorithm:
Given an integer:

1. Create a variable "sum" to which the multiples of 3 or 5 will be added
2. Iterate through the numbers from 1 to the given input integer
  a. Check if the number is evenly divisible by 3
    1. If yes, add the number to sum
    2. If no, move on to the next condition
  b. Check if the number is evenly divisible by 5
    1. If yes, add the number to sum
    2. If no, do nothing and move on to the next number
  c. Repeat A. and B. for all numbers between 1 and the given integer
3. Return the value of sum
=end

def multisum(number)
  sum = 0
  (1..number).each do |integer|
    if integer % 3 == 0
      sum += integer
    elsif integer % 5 == 0
      sum += integer
    end
  end
  sum
end

# p multisum(3) == 3
# p multisum(5) == 8
# p multisum(10) == 33
# p multisum(1000) == 234168

# Further Exploration
# Try writing solution with Enumerable#reduce (aka #inject)

def multisum_with_reduce(max_number)
  (1..max_number).reduce(0) do |sum, number|
    if number % 3 == 0 || number % 5 == 0
      sum + number
    else
      sum
    end
  end 
end

p multisum_with_reduce(3) == 3
p multisum_with_reduce(5) == 8
p multisum_with_reduce(10) == 33
p multisum_with_reduce(1000) == 234168