require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "Ingredientモデル" do
    let(:category) { create(:category) }
    let(:ingredient) { create(:ingredient, category: category) }

    context "食材の登録ができる場合" do
      it "食材情報に問題ない時、有効なこと" do
        expect(ingredient).to be_valid
      end
    end

    context "食材の登録ができない場合" do
      it "nameが空の時、無効なこと" do
        ingredient.name = ""
        expect(ingredient).to be_invalid
      end

      it "flavor_textが空の時、無効なこと" do
        ingredient.flavor_text = ""
        expect(ingredient).to be_invalid
      end

      it "category_idがnilの時、無効なこと" do
        ingredient.category_id = nil
        expect(ingredient).to be_invalid
      end
    end
  end
end
