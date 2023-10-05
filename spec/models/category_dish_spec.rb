require 'rails_helper'

RSpec.describe CategoryDish, type: :model do
  describe "CategoryDishモデル" do
    let(:category_dish) { create(:category_dish) }

    it "CategoryDishの情報に問題ない時、有効なこと" do
      expect(category_dish).to be_valid
    end

    it "category_idがnilの時、無効なこと" do
      category_dish.category_id = nil
      expect(category_dish).to be_invalid
    end

    it "dish_idがnilの時、無効なこと" do
      category_dish.dish_id = nil
      expect(category_dish).to be_invalid
    end
  end
end
