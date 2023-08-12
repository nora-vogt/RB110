# How does take work? Is it destructive? How can we find out?

arr = [1, 2, 3, 4, 5]
arr.take(2)
# -> [1, 2]

# We can check the Class Array docs -> #take
# take returns a new Array containign the first n element(s) of the calling array. n must be a positive integer.
# does not mutate the calling array
# this is like calling #first with an argument