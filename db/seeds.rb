ingredients = YAML.load_file('db/seeds/ingredients.yml')
dishes = YAML.load_file('db/seeds/dishes.yml')

ingredients.each do |ingredient_attributes|
  Ingredient.create(ingredient_attributes[1])
end

dishes.each do |dish_attributes|
  dish = Dish.create(dish_attributes[1])
  dish.ingredients << Ingredient.all.sample(rand(1..3))
end
