class CategoryDish < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :dish, optional: true

  validates :category_id, presence: { message: "を選択してください" }
  validates :dish_id, presence: { message: "を選択してください" }
end
