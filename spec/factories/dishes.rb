FactoryBot.define do
  factory :dish do
    name        { Faker::Food.ingredient }
    flavor_text { Faker::Lorem.sentence }
  end
end
