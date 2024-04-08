=begin
Spin Me Around in Circles

Input:
- string

Output:
- a string, same words, but each word's characters are reversed

Q:
Is the string returned by the spin_me method a new string, or the original object passed in as an argument?

Answer: 
The `spin_me` method will return a new string object. First, `#split` is called on the string referenced by `str`, which returns a new array containing string objects of all the characters from the calling string. 

We then iterate through that array of strings with `#each`. Within the `do...end` block on line 3, the `#reverse!` method is invoked on the string referenced by `word`, which mutates the string and reverses its characters. 

This mutates the string objects within the array - it does not have any effect on the original string passed in.

Finally, the `#join!` method is invoked on the array of characters, which returns a new string object. The `#join` invocation is the last evaluated expression within the `spin_me` method, and the new string returned by `#join` is returned by the method. 
=end

def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

string = "hello world"
p result = spin_me(string) # "olleh dlrow"

p string.object_id == result.object_id # false

# We could rework the method to return the array originally passed in as an argument

def spin_me(arr)
  arr.each do |word|
    word.reverse!
  end
end

arr = ['hello', 'world']
p arr.object_id == spin_me(arr).object_id # true