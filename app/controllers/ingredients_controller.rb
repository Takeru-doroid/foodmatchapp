class IngredientsController < ApplicationController
  before_action :check_admin, except: [:index, :show]
  include IngredientsHelper

  def index
    @category_ingredients = Category.all.includes(ingredients: { image_attachment: :blob })
  end

  def show
    @ingredient = Ingredient.find(params[:id])
    result_recipe = calculate_recipe(@ingredient)
    @recipe_category = result_recipe.values.first
    @recipe_dish = result_recipe.keys.first
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

  def check_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "権限がありません"
    end
  end
end
