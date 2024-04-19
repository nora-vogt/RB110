password = nil

def set_password
  puts 'What would you like your password to be?'
  gets.chomp
end

def verify_password(password)
  puts '** Login **'
  print 'Password: '
  input = gets.chomp

  if input == password
    puts 'Welcome to the inside!'
  else
    puts 'Authentication failed.'
  end
end

if !password
  password = set_password
end

verify_password(password)

=begin
1. What is causing the error?
2. How can you fix it?
3. Does the code now behave as expected?

The code as written raises a `NameError` on line 14, when attempting to compare `input` to the value of `password`. This happens due to local variable scoping rules in Ruby. The comparison of `input` to `password` occurs within the method definition scope of the `verify_password` method. Method definitions have self-contained scope. Local variables initialized outside of a method definition scope are not accessible within the method definition scope.

The local variable `password` was initialized on line 1 in the `main` program scope, and is not accessible within the method definition scope of `verify_password`. In order to fix this, we need to define a parameter for `verify_password` in order to pass in the value of `password` as an argument when `verify_password` is invoked on line 25 (see above changes).

This fixes the `NameError`, however our program is still not working as expected. Password authentication is failing. This happens because in the `set_password` method definition, when the user chooses a password, the password string is assigned to the local variable `new_password` on line 5. Then, a local variable `password` is initialized and assigned to the value of `new_password`. Due to self-contained method definition scope, this `password` variable is a separate variable from the `password` local variable initialized in the `main` scope on line 1. The `password` initialized on line 6 is only accessible within the `set_password` method definition scope.

To fix this, we could reassign `password` in the main scope on line 21 to the return value of the `set_password` method. We can also clean up the unncessary variable assignmet within the `set_password` method definition, and simply have the method return the result of getting input from the user with `#gets`. (see above)
=end