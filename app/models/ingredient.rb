class Ingredient < ApplicationRecord
  validates :name, presence: true
  
  has_many :dish_ingredients
  has_many :dishes, through: :dish_ingredients
end
