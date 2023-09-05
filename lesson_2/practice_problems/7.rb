#Given this code, what would be the final values of a and b?
a = 2
b = [5, 8]
arr = [a, b] # [2, [5, 8]]

arr[0] += 2 # Array#[]=; reassigns the object at index 0 in arr. Though arr[0] initially references the same object that a references (the integer 2), this code only reassigns arr[0], and does not reassign a.
# arr[0] = arr[0] + 2; arr[0] = 2 + 2 => 4
# arr == [4, [5, 8]]

arr[1][0] -= a # arr[1][0] = arr[1][0] - a; arr[1][0] = 5 - 2 => 3
# "The value of b did change because b is an array and we are modifying that array by assigning a new value at index 0 of that array.""

p a # 2
p b #[3, 8]
p arr # [4, [3, 8]]

