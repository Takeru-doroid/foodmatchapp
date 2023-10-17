FactoryBot.define do
  factory :dish do
    name        { "串焼きキノコ" }
    flavor_text { Faker::Lorem.word }
    after(:build) do |dish|
      if dish.name == "串焼きキノコ"
        dish.image.attach(io: File.open("app/assets/images/dishes/#{dish.name}.png"), filename: "#{dish.name}.png")
      end
    end
  end
end
