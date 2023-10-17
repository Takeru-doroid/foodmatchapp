module SelectIngredientModule
  def select_ingredient(ingredients_indices)
    ingredients_indices.each do |index|
      find("##{ingredient[index].name}").click
    end
    click_on "料理する"
  end
end
