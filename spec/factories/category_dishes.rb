FactoryBot.define do
  factory :category_dish do
    association :category
    association :dish
  end
end
