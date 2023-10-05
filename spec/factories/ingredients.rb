FactoryBot.define do
  factory :ingredient do
    name { "ソラダケ" }
    flavor_text { Faker::Lorem.word }
  end
end
