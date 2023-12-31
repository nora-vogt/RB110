arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]
p arr1[2][1][3]
# alternate, using negative indices
p arr1[-1][-1][-1]

arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]
p arr2[1][:third][0]

arr3 = [['abc'], ['def'], {third: ['ghi']}]
# third element of arr3 => hash
# access value associated with key :third => array
# access first element of array => string
# access first character of string => 'g'
p arr3[2][:third][0][0]

hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}
p hsh1['b'][1]

hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}
p hsh2[:third].key(0)

# alternate
p hsh2[:third].keys[0]