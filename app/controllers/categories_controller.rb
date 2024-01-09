class CategoriesController < ApplicationController
  before_action :check_admin

  def new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to new_category_path, notice: "カテゴリの作成に成功しました"
    else
      @categories = Category.all
      render :new, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def check_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "権限がありません"
    end
  end
end
