class Ingredient < ApplicationRecord
  belongs_to :category, optional: true

  has_one_attached :image

  validates :name, presence: true
  validates :flavor_text, presence: true
  validates :category_id, presence: { message: "を選択してください" }
end
