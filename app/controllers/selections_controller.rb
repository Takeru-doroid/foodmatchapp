class SelectionsController < ApplicationController
  include SelectionsHelper

  def display_selection
    @category_ingredients = Category.all.includes(ingredients: { image_attachment: :blob })
    @select_ingredients = Ingredient.where(id: params[:select_ingredients_ids])
    @display_dish = find_display_dish(params[:category_ids], @select_ingredients)
    @have_effect_ingredient = find_cooking_effect(@select_ingredients)
  end

  def calculate_dishes
    select_ingredients_ids = params[:ingredient_ids] || []
    if select_ingredients_ids.size == 0
      flash[:alert] = "少なくとも1つ以上は食材を選択してください"
      redirect_to selections_display_selection_path
    else
      category_ids = Ingredient.where(id: select_ingredients_ids).pluck(:category_id)
      redirect_to selections_display_selection_path(select_ingredients_ids: select_ingredients_ids, category_ids: category_ids)
    end
  end
end
