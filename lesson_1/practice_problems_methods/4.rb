# What is the return value of each_with_object in the following code? Why?

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

# return value: {"a" => "ant", "b" => "bear", "c" => "cat"}

# each_with_object will return a new hash, because a Hash object was passed as an argument to the method invocation. The hash will be populated based on the code executed in the block. In this case, the key is the first character of the current string passed to the block parameter `value`, and the associated value is the whole string passed to `value`.