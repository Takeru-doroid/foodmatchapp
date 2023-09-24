class Ingredient < ApplicationRecord
  belongs_to :category

  has_one_attached :image

  validates :name, presence: true
  validates :flavor_text, presence: true
end
