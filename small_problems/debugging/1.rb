=begin
Countdown!
Our countdown to launch isn't behaving as expected. Why? Change the code so that our program successfully counts down from 10 to 1.
=end

def decrease(counter)
  counter -= 1
end

counter = 10

10.times do
  puts counter
  decrease(counter)
end

puts 'LAUNCH!'

=begin
In this code, the attempt to decrement the `counter` variable from within the `decrease` method definition is causing unexpected behavior. 

On line 13, the `decrease` method is invoked and passed the object referenced by `counter` as an argument. 

`decrease` is defined on lines 1-3, with one parameter, `counter`. When invoked, this `counter` variable is bound to the same `Integer`` object that is passed in as an argument (the integer `10`).

On line 6 `counter -= 1` is executed. This code is shorthand for `counter = counter - 1`. In Ruby, variable assigment is not a mutating operation, it simply changes the object that the target variable references. This code is reassigning the variable local to the method definition `counter` to reference a new integer, `9`. It does not change the reference of the `counter` variable initialized in the main scope on line 5 - that variable continues to reference the integer `10` after the `decrease` method returns `9`. 

Additionally, `Integer` objects are immutable, so there is no way for the `decrease` method to mutate the `10` initially assigned to `counter`.

This is why the current code outputs `10` ten times. 

In order to successfully output a countdown from `10`, we could reassign the `counter` variable in the main scope to the return value of the `decrease` method. Now, when the `decrease` method returns the result of `counter -= 1`, the main scope `counter` variable is reassigned to that return value.
=end

def decrease(counter)
  counter -= 1
end

counter = 10

10.times do
  puts counter
  counter = decrease(counter)
end

puts 'LAUNCH!'