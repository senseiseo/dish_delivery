class Order < ApplicationRecord
  def self.dish_counts
    Order
      .joins("INNER JOIN jsonb_array_elements(order_data) AS order_item ON true")
      .joins("INNER JOIN dishes ON dishes.id = (order_item->>'dish_id')::int")
      .group("dishes.name")
      .select("dishes.name AS dish_name, COUNT(*) AS count")
      .order("count DESC, dish_name ASC")
      .map do |result|
        {
          name: result.dish_name,
          count: result.count.to_i
        }
      end
  end
  
  def build_order_data(order_items_params)
    order_data = {}

    order_items_params.each do |order_item_params|
      dish = Dish.find(order_item_params[:dish_id])
      ingredient_ids = order_item_params[:ingredient_id]
      ingredient_ids = ingredient_ids.split(',')
      included = order_item_params[:included] != '1'

      order_data[dish.name] ||= {
        dish_id: dish.id,
        dish_name: dish.name,
        ingredients: []
      }

      ingredient_ids.each do |ingredient_id|
        ingredient = Ingredient.find(ingredient_id)
        order_data[dish.name][:ingredients] << {
          ingredient_name: ingredient.name,
          included: included
        }
      end
    end

    order_data.values unless order_data.empty?
  end
end
