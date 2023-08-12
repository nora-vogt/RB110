# How does count treat the block's return value? How can we find out?

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

# count will use the truthiness of the block's return value: count will return the number of elements for which the block evaluates as true. In this case, count will return 2.

# found from docs: Array > #count