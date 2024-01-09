class Dish < ApplicationRecord
  has_many :category_dishes
  has_many :categories, through: :category_dishes
  has_many :posts, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :flavor_text, presence: true
end
