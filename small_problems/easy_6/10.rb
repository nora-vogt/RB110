array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value }
# array2 = ["Moe", "Larry", "Curly", "Shemp", "Harpo", "Chico", "Groucho", "Zeppo"]
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
# ["Moe", "Larry", "CURLY", "SHEMP", "Harpo", "CHICO", "Groucho", "Zeppo"]
puts array2

=begin
What will the following code print, and why? Don't run the code until you have tried to answer.

This code will output each string element in `array2` on a separate line:
"Moe"
"Larry"
"CURLY"
"SHEMP"
"Harpo"
"CHICO"
"Groucho"
"Zeppo"

On line 2, `array2` is initialized and assigned to an empty array object. On line 3, the `#each` method is invoked on `array1`, iterating through each element and passing each element to the block parameter `value`. Within the block, the `#<<` method is called, pushing the object currently referenced by `value` into `array2`. `#<<` is a mutating method, meaning that `array2` will be mutated when each new value is added to the array.

At this point, we have two separate `Array` objects, referenced by `array1` and `array2`, respectively, however each array contains references to the same set of `String` elements.

On line 4, the `#each` method is invoked again to iterated through the values in `array1`, this time within the block destructively upcasing the current value of `value` if the string element starts with the character "C" or "S". This will result in any string where the string starts with the characters "C" or "S" being mutated and upcased. Because each element in `array1` is a reference to the same `String` object also referenced at the same index position in `array2`, when we mutate those strings while iterating through `array1`, we will see the changes reflected when passing `array2` as an argument to `#puts`, which will output each string element on a new line.


# Further Exploration:
In this example, the `#each` block on line 3 copies the reference to the current value of `value` to `array2`, mutating `array2`. Because each array contains the same references to string objects, this can cause trouble if you want to mutate the values in only one of the arrays. Right now, it isn't possible to mutate only the objects in `array1`, because `array2` also contains references to those same objects.

One way to avoid this is to create a shallow copy using `#dup` or `#clone`. These methods will create a copy of the calling object. We could add this method invocation to line 3:

`array1.each { |value| array2 << value.dup }`

Now, `#dup` will return a new string object that has the same value as `value`, but is a new object in memory. `array2` will now be populated by references to new string objects. With two arrays and two sets of objects, it is now possible to mutate the values in only one array:
=end

array1 = %w(Moe Larry Curly Shemp Harpo Chico Groucho Zeppo)
array2 = []
array1.each { |value| array2 << value.dup }
array1.each { |value| value.upcase! if value.start_with?('C', 'S') }
# ["Moe", "Larry", "CURLY", "SHEMP", "Harpo", "CHICO", "Groucho", "Zeppo"]
p array1 # ["Moe", "Larry", "CURLY", "SHEMP", "Harpo", "CHICO", "Groucho", "Zeppo"]
p array2 # ["Moe", "Larry", "Curly", "Shemp", "Harpo", "Chico", "Groucho", "Zeppo"
p array1[0].object_id == array2[0].object_id # false