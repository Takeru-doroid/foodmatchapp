class IngredientsController < ApplicationController
  def index
    @category_ingredients = Category.all.includes(ingredients: { image_attachment: :blob })
  end

  def show
    @ingredient = Ingredient.find(params[:id])
  end

  def new
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to new_ingredient_path, notice: "食材の作成に成功しました"
    else
      @ingredients = Ingredient.all
      render :new, status: :unprocessable_entity
    end
  end

  private
  def ingredient_params
    params.require(:ingredient).permit(:name, :flavor_text, :cooking_effect, :category_id, :image)
  end
end
