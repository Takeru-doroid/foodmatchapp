module IngredientsHelper
  def calculate_recipe(ingredient)
    all_dish_ids = Dish.joins(:category_dishes).
      where(category_dishes: { category_id: ingredient.category_id }).
      pluck(:dish_id)
    dish_ids = Category.joins(:category_dishes).
      where(category_dishes: { dish_id: all_dish_ids }).
      pluck(:dish_id).
      tally.
      select { |k, v| v > 1 }.
      map(&:first)
    recipe_dish = Dish.find_by(id: dish_ids)
    category_ids = Category.joins(:category_dishes).
      where(category_dishes: { dish_id: recipe_dish }).
      pluck(:category_id).select { |i| i != ingredient.category_id }
    other_ingredient = Ingredient.where(category_id: category_ids).shuffle[0]
    recipe_hash = { recipe_dish => other_ingredient }
    recipe_hash
  end
end
