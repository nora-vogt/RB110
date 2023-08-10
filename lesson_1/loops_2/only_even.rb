number = 0

until number == 10
  number += 1
  puts number
  next if number.odd?
end

# Further Exploration
# if `next` were placed before incrementing number, on the first iteration of the loop, `if number.odd?` would evaluate as false and the `next` will not execute. `number` will then increment by 1, and the value of number (1) will be printed. On the second iteration, the `next` condition would evaluate as true - skipping to the next iteration. However, no code after the `next` keyword is executed, meaning that `numbers` is never incremented. This traps us in an infinite loop.

# If `next` were placed after the `#puts` invocation, every number would be printed - not just the evens. A `next` as the last line of the loop isn't useful, as all the code in the block has already executed, and the subsequent iteration will begin regardless of how the `next` condition evaluates.