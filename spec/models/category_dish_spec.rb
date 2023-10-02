require 'rails_helper'

RSpec.describe CategoryDish, type: :model do
  describe "CategoryDishモデル" do
    let(:category) { create(:category) }
    let(:dish) { create(:dish) }
    let(:category_dish) { create(:category_dish, category: category, dish: dish) }

    it "CategoryDishの登録に問題ないこと" do
      expect(category_dish).to be_valid
    end
  end
end
