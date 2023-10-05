require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "Dishモデル" do
    let(:dish) { create(:dish) }

    context "料理の登録ができる場合" do
      it "料理情報に問題ない時、有効なこと" do
        expect(dish).to be_valid
      end
    end

    context "料理の登録ができない場合" do
      it "nameが空の時、無効なこと" do
        dish.name = ""
        expect(dish).to be_invalid
      end

      it "flavor_textが空の時、無効なこと" do
        dish.flavor_text = ""
        expect(dish).to be_invalid
      end
    end
  end
end
