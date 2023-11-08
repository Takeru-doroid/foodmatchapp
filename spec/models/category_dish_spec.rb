require 'rails_helper'

RSpec.describe CategoryDish, type: :model do
  describe "CategoryDishモデル" do
    let(:category_dish) { create(:category_dish) }

    context "CategoryDishの登録ができる場合" do
      it "CategoryDishに問題がないこと" do
        expect(category_dish).to be_valid
      end
    end

    context "CategoryDishの登録ができない場合" do
      it "category_idが空であれば登録できないこと" do
        category_dish.category_id = ""
        category_dish.valid?
        expect(category_dish.errors.full_messages).to include "紐付けるカテゴリを選択してください"
      end

      it "dish_idが空であれば登録できないこと" do
        category_dish.dish_id = ""
        category_dish.valid?
        expect(category_dish.errors.full_messages).to include "紐付ける料理を選択してください"
      end
    end
  end
end
