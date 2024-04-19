def move(n, from_array, to_array)
  #return if n == 0 || from_array.empty?
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# recursion should stop when n items have been removed from from_array
# n == 2
# first invocation:
  # 1 item moved
  # move(1) invoked - second time
    # n == 1
    # 1 item moved
    # move(0) invoked - third time
      # return if n == 0 

# Example

# todo = ['study']
todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']


=begin
Getting Things Done

Line 11 produces a SystemStackError due to how recursion is utilized within the `move` method definition. 

A SystemStackError is produced when trying to perform a calculation so complex that the capacity of the stack is exceeded. In this code, `move` is recursively called from within itself an infinite number of times, which raises this error.

When `move` is invoked on line 11, the first argument passed in is the Integer number of items we would like to remove from our todo list. 

Within the `move` method definition, the `move` method is invoked again on line 3, this time passing in `n - 1` as an argument.

The issue here is that `n` is not utilized anywhere else within the `move` method definition, which means that `move` is recursively invoked infinitely, each time passing in `n - 1` (`n` will reference negative integers.)

We want `move` to excute only until `n == 0`, meaning that the `Integer` number of items that we specified have been removed from the list. To fix that, we need to add a conditional under which the recursion stops.

We want to stop calling `move` when `n == 0`, meaning there are no more items to remove from our todo list. So we can add `return if n == 0` to the beginning of the `move` method definition.

# Further Exploration
If the length of `from_array` is smaller than `n`, then `from_array` will eventually reference an empty_array, upon which `#shift` is invoked. `#shift` returns `nil` when invoked on an empty array, and this `nil` value will be added to `to_array`. `nils` will be added until the method returns when `n == 0`.

To prevent this, we can add an OR to our `if` condition, returning from the method when `n == 0` or `from_array` is empty.

NOTE: output the values of n, from_array, and to_array with p at start of method def to see recursion in action.
=end