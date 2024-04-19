arr = ["9", "8", "7", "10", "11"]
p (arr.sort do |x, y|
    y.to_i <=> x.to_i
  end)


# Expected output: ["11", "10", "9", "8", "7"] 
# Actual output: ["10", "11", "7", "8", "9"] 

# In order to get the expected output, we need to add parenthesis around the `#sort` invocation and the block argument. This is due to operator precedence rules in Ruby. `do...end` blocks have a lower precedence than `#p`. `arr.sort` will bind to the `#p` invocation and be evalauted without a block, which returns a new array with elements sorted based on their String values.

# When we add parenthesis, `#sort` is invoked and its block will execute during each iteration, and then the return value of the method is passed to `#p` as an argument.

# We could also change this code to use a `{}` block, as a block denoted by curly braces has higher precedence than a `do...end` block. The `{}` block will bind more tightly to `arr.sort`: 
p arr.sort { |x, y| y.to_i <=> x.to_i }