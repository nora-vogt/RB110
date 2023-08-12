# What is the return value of the following statement? Why?

['ant', 'bear', 'caterpillar'].pop.size 
# => 11

# This code first executes Array#pop, which removes and returns the last element in the calling array, the String 'caterpillar'. The `String#size` is then invoked on 'caterpillar', which returns the number of characters in the string -- 11.