FactoryBot.define do
  factory :post do
    title { "タイトル" }
    body { Faker::Lorem.word }
    association :user
    association :dish
  end
end
