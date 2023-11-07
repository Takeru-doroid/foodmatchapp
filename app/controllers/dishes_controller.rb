class DishesController < ApplicationController
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
end
