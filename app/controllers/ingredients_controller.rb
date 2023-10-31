class IngredientsController < ApplicationController
  def index
    @category_ingredients = Category.all.includes(ingredients: { image_attachment: :blob })
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end
end
