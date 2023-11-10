class CategoryDishesController < ApplicationController
  before_action :check_admin

  def new
    @category_dish = CategoryDish.new
    @category_dishes = CategoryDish.all
  end

  def create
    @category_dish = CategoryDish.new(category_dish_params)
    if @category_dish.save
      redirect_to new_category_dish_path, notice: "関連付けを行いました"
    else
      @category_dishes = CategoryDish.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_dish_params
    params.require(:category_dish).permit(:category_id, :dish_id)
  end

  def check_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "権限がありません"
    end
  end
end
