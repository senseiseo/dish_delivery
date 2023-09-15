require 'rails_helper'

RSpec.describe Dish, type: :model do
  context 'validation' do 
    let(:dish) { Dish.new(name: "Суп") }

    it "is valid with a name" do
      expect(dish).to be_valid
    end
  end

  it "is not valid without a name" do
    ingredient = Dish.new(name: nil)
    ingredient.valid?

    expect(ingredient.errors[:name]).to include("can't be blank")
  end

  it "has many dish_ingredients" do
    dish = Dish.reflect_on_association(:dish_ingredients)

    expect(dish.macro).to eq(:has_many)
  end
end
