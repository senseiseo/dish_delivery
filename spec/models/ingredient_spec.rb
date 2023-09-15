require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it "is valid with a name" do
    ingredient = Ingredient.new(name: "Соль")
    expect(ingredient).to be_valid
  end

  it "is not valid without a name" do
    ingredient = Ingredient.new(name: nil)
    ingredient.valid?
    expect(ingredient.errors[:name]).to include("can't be blank")
  end

  it "has many dishes" do
    ingredient = Ingredient.reflect_on_association(:dishes)
    expect(ingredient.macro).to eq(:has_many)
  end
end