require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "dish_counts" do
    it "returns a hash with dish counts" do
      dish1 = Dish.create(name: "Dish 1")
      dish2 = Dish.create(name: "Dish 2")
      dish3 = Dish.create(name: "Dish 3")
      Order.create(order_data: '[{"dish_id": ' + dish1.id.to_s + '}, {"dish_id": ' + dish2.id.to_s + '}]')
      Order.create(order_data: '[{"dish_id": ' + dish2.id.to_s + '}, {"dish_id": ' + dish3.id.to_s + '}]')
      dish_counts = Order.dish_counts
      
      expect(dish_counts).to eq([
        { name: "Dish 2", count: 2 },
        { name: "Dish 1", count: 1 },
        { name: "Dish 3", count: 1 }
      ])
    end

    it "returns an empty array if no orders" do
      dish_counts = Order.dish_counts
      expect(dish_counts).to eq([])
    end
  end

  describe "build_order_data" do
    it "builds order data hash" do
      dish = Dish.create(name: "Dish")
      ingredient1 = Ingredient.create(name: "Ingredient 1")
      ingredient2 = Ingredient.create(name: "Ingredient 2")
      order_items_params = [
        {
          dish_id: dish.id,
          ingredient_id: "#{ingredient1.id},#{ingredient2.id}",
          included: '1'
        }
      ]
      order_data = Order.new.build_order_data(order_items_params)

      expect(order_data).to eq([
        {
          dish_id: dish.id,
          dish_name: dish.name,
          ingredients: [
            {
              ingredient_name: ingredient1.name,
              included: false
            },
            {
              ingredient_name: ingredient2.name,
              included: false
            }
          ]
        }
      ])
    end

    it "returns nil if order empty" do
      order_data = Order.new.build_order_data([])
      expect(order_data).to be_nil
    end
  end
end
