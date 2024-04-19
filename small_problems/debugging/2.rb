=begin
HEY YOU!

String#upcase! is a destructive method, so why does this code print HEY you instead of HEY YOU? Modify the code so that it produces the expected output.
=end

def shout_out_to(name)
  name.chars.each { |c| c.upcase! }

  puts 'HEY ' + name
end

p shout_out_to('you') # expected: 'HEY YOU'

=begin
This code prints "HEY you" instead of "HEY YOU" because of line 8 and the invocation of the `#chars` method on the string referenced by `name`. `#chars` returns a new array containing strings of each character in the calling string. 

When we iterate through this array with `#each` and use `#upcase!` to mutate each character, we are only mutating the `String` objects within this new array, instead of mutating the string itself that `name` references. 

Nothing is done with this new array containing upcased strings, and if check the value of `name` on line 9 after `#each` returns, we see that `name` still references the original, un-mutated string `"you"`.

One way to fix this would be to simply call `name.upcase!` on line 8. This way, the string that `name` references is mutated to the upcased version. `#upcase!` upcases all characters in the string, so there is no need to break the string into an array and iterate.
=end

def shout_out_to(name)
  name.upcase!
  
  puts 'HEY ' + name
end

p shout_out_to('you') # => 'HEY YOU'