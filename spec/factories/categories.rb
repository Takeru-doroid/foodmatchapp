FactoryBot.define do
  factory :category do
    name { Faker::Food.name }
  end
end
