require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "Dishモデル" do
    let(:dish) { create(:dish) }

    context "Dishの登録ができる場合" do
      it "料理情報に問題がないこと" do
        expect(dish).to be_valid
      end
    end

    context "Dishの登録ができない場合" do
      it "nameが空であれば登録できないこと" do
        dish.name = ""
        dish.valid?
        expect(dish.errors.full_messages).to include "料理名を入力してください"
      end

      it "flavor_textが空であれば登録できないこと" do
        dish.flavor_text = ""
        dish.valid?
        expect(dish.errors.full_messages).to include "料理の説明テキストを入力してください"
      end
    end
  end
end
