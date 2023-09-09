class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,128}\z/i
  validates :name, presence: true
  validates :email, presence: true, if: -> { errors_blank?(:email) }
  validates :email, format: {with: VALID_EMAIL_REGEX}, if: -> { errors_blank?(:email) }
  validates :password, presence: true, on: :create, if: -> { errors_blank?(:password) }
  validates :password, format: {with: VALID_PASSWORD_REGEX,
                                message: "は半角英字・半角数字をそれぞれ1文字以上含む必要があります"}, allow_blank: true, if: -> { errors_blank?(:password) }

  def errors_blank?(attribute)
    errors[attribute].blank?
  end

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.name = "ゲストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
