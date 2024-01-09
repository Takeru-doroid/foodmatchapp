FactoryBot.define do
  factory :ingredient do
    name        { "ソラダケ" }
    flavor_text { Faker::Lorem.word }
    after(:build) do |ingredient|
      if ingredient.name == "ソラダケ"
        ingredient.image.attach(io: File.open(Rails.root.join("spec", "support", "ソラダケ.JPG")), filename: "ソラダケ.JPG")
      end
    end
  end
end
