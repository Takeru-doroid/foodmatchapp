require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "Ingredientモデル" do
    let!(:category) { create(:category) }
    let!(:ingredient) { create(:ingredient, category: category) }

    context "Ingredientの登録ができる場合" do
      it "食材情報に問題がないこと" do
        expect(ingredient).to be_valid
      end
    end

    context "Ingredientの登録ができない場合" do
      it "nameが空であれば登録できないこと" do
        ingredient.name = ""
        ingredient.valid?
        expect(ingredient.errors.full_messages).to include "食材名を入力してください"
      end

      it "flavor_textが空であれば登録できないこと" do
        ingredient.flavor_text = ""
        ingredient.valid?
        expect(ingredient.errors.full_messages).to include "食材の説明テキストを入力してください"
      end

      it "category_idが空であれば登録できないこと" do
        ingredient.category_id = ""
        ingredient.valid?
        expect(ingredient.errors.full_messages).to include "紐付けるカテゴリを選択してください"
      end
    end
  end
end
