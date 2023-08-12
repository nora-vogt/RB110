# What does shift do in the following code? How can we find out?

hash = { a: 'ant', b: 'bear' }
hash.shift # => [:a, 'ant']

# We can check the Hash class documentation:
# shift → [key, value] or nil

# Hash#shift will remove and return the first entry in the calling hash, mutating the hash. Those values will be returned as a 2-element array.