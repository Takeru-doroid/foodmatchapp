FactoryBot.define do
  factory :dish do
    name        { "串焼きキノコ" }
    flavor_text { Faker::Lorem.word }
    after(:build) do |dish|
      if dish.name == "串焼きキノコ"
        dish.image.attach(io: File.open(Rails.root.join("spec", "support", "串焼きキノコ.png")), filename: "串焼きキノコ.png")
      end
    end
  end
end
