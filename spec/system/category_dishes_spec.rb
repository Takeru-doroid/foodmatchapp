require 'rails_helper'

RSpec.describe CategoryDish, type: :system do
  describe "category_dishes" do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, role: 1) }
    let!(:category) { create(:category, id: 1, name: "キノコ類") }
    let!(:other_category) { create(:category, id: 2, name: "肉類") }
    let!(:dish) { create(:dish, name: "串焼きキノコ") }
    let!(:other_dish) { create(:dish, name: "串焼き肉キノコ添え") }
    let!(:category_dish) { create(:category_dish, category: category, dish: dish) }

    describe "newページ" do
      context "管理者権限を持たない場合" do
        before { login(user) }

        it "管理者権限を持たないユーザーは、newページにアクセスできないこと" do
          visit new_category_dish_path
          expect(page).to have_content "権限がありません"
        end
      end

      context "管理者権限を持つ場合" do
        before do
          login(admin_user)
          visit new_category_dish_path
        end

        it "現状紐付け関係にあるカテゴリIDが表示されていること" do
          expect(page).to have_content "#{category.id}"
        end

        it "現状紐付け関係にある料理IDが表示されていること" do
          expect(page).to have_content "#{dish.id}"
        end

        it "カテゴリと料理を選択すれば、紐付けができること" do
          select "肉類", from: "category_dish_category_id"
          select "串焼き肉キノコ添え", from: "category_dish_dish_id"
          click_on "作成する"
          expect(page).to have_content "#{other_category.id}"
          expect(page).to have_content "#{other_dish.id}"
        end
      end
    end
  end
end
