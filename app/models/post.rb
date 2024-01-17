class Post < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :dish, optional: true
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: { message: "と紐付けてください" }
  validates :dish_id, presence: { message: "と紐付けてください" }

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def create_notification_by(current_user)
    temp = Notification.
      where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, "like"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: "like"
      )
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
end
