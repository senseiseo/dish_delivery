class Dish < ApplicationRecord
  validates :name, presence: true

  has_many :dish_ingredients, dependent: :destroy
  has_many :ingredients, through: :dish_ingredients
end
