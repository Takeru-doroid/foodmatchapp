FactoryBot.define do
  factory :dish do
    name { "串焼きキノコ" }
    flavor_text { Faker::Lorem.word }
  end
end
