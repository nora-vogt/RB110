require 'pry'
# Given this data structure write some code to return an array containing the colors of the fruits, and the sizes of the vegetables. The sizes should be uppercase and the colors should be capitalized.

# Return a new array containing
  # color of the fruits
    # capitalize colors
  # size of the vegetables
    # make size uppercase

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

result = hsh.map do |_, details|
 if details[:type] == 'fruit'
  details[:colors].map {|string| string.capitalize} # could also do .map(&:capitalize)
 else
  details[:size].upcase
 end
end

p result
p result == [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"] # true
