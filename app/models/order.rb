class Order < ApplicationRecord
  def self.dish_counts
    online_orders = Order.all
    dish_counts = {}

    online_orders.each do |order|
      order_data = JSON.parse(order.order_data)
      order_data.each do |order_item|
        dish_id = order_item['dish_id']
        dish_counts[dish_id] ||= 0
        dish_counts[dish_id] += 1
      end
    end

    sorted_dish_counts = dish_counts.map do |dish_id, count|
      {
        name: Dish.find(dish_id).name,
        count: count
      }
    end.sort_by { |item| -item[:count] }

    sorted_dish_counts
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
