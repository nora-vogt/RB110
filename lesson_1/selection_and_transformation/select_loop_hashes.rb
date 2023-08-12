def select_fruit(hash)
  selected_fruits = {}
  produce = hash.keys
  counter = 0

  loop do
    current_produce = produce[counter]

    if hash[current_produce] == 'Fruit'
      selected_fruits[current_produce] = hash[current_produce]
    end

    counter += 1
    break if counter == produce.size
  end
  selected_fruits
end

# LS Solution
# def select_fruit(produce_list)
#   produce_keys = produce_list.keys
#   counter = 0
#   selected_fruits = {}

#   loop do
#     # this has to be at the top in case produce_list is empty hash
#     break if counter == produce_keys.size

#     current_key = produce_keys[counter]
#     current_value = produce_list[current_key]

#     if current_value == 'Fruit'
#       selected_fruits[current_key] = current_value
#     end

#     counter += 1
#   end

#   selected_fruits
# end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}