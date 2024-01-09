FactoryBot.define do
  factory :user do
    name                  { Faker::Internet.username }
    email                 { Faker::Internet.email }
    password              { "validpassword12345" }
    password_confirmation { password }
  end
end
