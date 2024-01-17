FactoryBot.define do
  factory :notification do
    association :post
    association :visiter, factory: :user
    association :visited, factory: :user
  end
end
