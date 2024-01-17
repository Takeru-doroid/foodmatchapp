class Notification < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :visiter, class_name: "User", optional: true
  belongs_to :visited, class_name: "User", optional: true

  scope :orderd, -> { order(created_at: :desc) }
end
