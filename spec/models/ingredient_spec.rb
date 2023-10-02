require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "Ingredientモデル" do
    let(:category) { create(:category) }
    let(:ingredient) { create(:ingredient, category: category) }

    context "食材の登録ができる場合" do
      it "食材情報に問題がないこと" do
        expect(ingredient).to be_valid
      end
    end

    context "食材の登録ができない場合" do
      it "nameが空であれば登録できないこと" do
        ingredient.name = ""
        expect(ingredient).to be_invalid
      end

      it "flavor_textが空であれば登録できないこと" do
        ingredient.flavor_text = ""
        expect(ingredient).to be_invalid
      end
    end
  end
end
