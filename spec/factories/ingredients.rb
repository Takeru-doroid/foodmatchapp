FactoryBot.define do
  factory :ingredient do
    name        { "ソラダケ" }
    flavor_text { Faker::Lorem.word }
    after(:build) do |ingredient|
      if ingredient.name == "ソラダケ"
        ingredient.image.attach(io: File.open("app/assets/images/ingredients/mushrooms/#{ingredient.name}.JPG"),
                                filename: "#{ingredient.name}.JPG")
      end
    end
  end
end
