class DishesController < ApplicationController
  before_action :check_admin

  def new
    @dish = Dish.new
    @dishes = Dish.all
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      redirect_to new_dish_path, notice: "料理の作成に成功しました"
    else
      @dishes = Dish.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def dish_params
    params.require(:dish).permit(:name, :flavor_text, :image)
  end

  def check_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "権限がありません"
    end
  end
end
