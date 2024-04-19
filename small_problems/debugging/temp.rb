# def remove_evens!(arr)
#   arr.each do |num|
#     if num % 2 == 0
#       arr.delete(num)
#     end
#   end
#   arr
# end

#
#[1,1,2,3,4,6,8,9]
# one - 1
# two: 1
# three: 2 (delete ) [1,1, 3,4,6,8,9]
# four: 4 (delete) [1,1, 3,6,8,9]
# fifth: 8

#p remove_evens!([1,1,2,3,4,6,8,9])
# expected return value [1, 1, 3, 9]
# actual return value [1, 1, 3, 6, 9]
# What's wrong, why aren't we getting expected output? How to fix it?

=begin
The `remove_evens!` method is defined on lines 1-8 with one block parameter, `arr`. When the method is invoked on line 10, `arr` is bound to the array passed in as an argument, `[1,1,2,3,4,6,8,9]`.

Within the method definition, the `#each` method is invoked to iterate through each integer in the array referenced by `arr`. Within the block passed to `#each` as an argument, a conditional statement is evaluated: `num % 2 == 0`. This code checks if `num` is evenly divisible by `2`, and returns a Boolean.

When the integer that `num` references is evenly divisible by `2`, `arr.delete(num)` is executed. `Array#delete` is a mutating method, and when we mutate the calling collection while iterating through it, unexpected results can be produced. 

In this case, `Array#delete` destructively removes even integers from the array referenced by `arr`, changing the size of the array and shifting integers to different index positions. On the fourth iteration of `#each`, `num` references `4`, which is even. `4` is destructively removed from `arr`.

`arr` now has a value of `[1,1, 3,6,8,9]` on the fifth iteration, when we should be expecting `6` to be passed to `num`. However, because previous element in the array have been deleted, `6` is now at an earlier index position, causing it to be skipped entirely and never passed to `num`.

To fix this, we can change the method that we use to mutate the array referenced by `arr` within the `remove_evens!` method definition. Using a built-in iterator that returns a mutated collection, we avoid the problematic issue of iterating through a collection and trying to mutate it while iterating.
=end

def remove_evens!(arr)
  arr.select! { |num| num.odd? }
end

p remove_evens!([1,1,2,3,4,6,8,9])