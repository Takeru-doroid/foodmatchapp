FactoryBot.define do
  factory :ingredient do
    name           { Faker::Food.ingredient }
    flavor_text    { Faker::Lorem.sentence }
    cooking_effect { Faker::Lorem.word }
    category_id    { 1 }
  end
end
