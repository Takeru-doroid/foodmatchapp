class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :dish, optional: true
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: { message: "と紐付けてください" }
  validates :dish_id, presence: { message: "と紐付けてください" }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
