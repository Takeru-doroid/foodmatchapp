require "rails_helper"

RSpec.describe Dish, type: :system do
  describe "dishes" do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, role: 1) }
    let!(:dish) { create(:dish) }

    describe "newページ" do
      context "管理権限を持たない場合" do
        before { login(user) }

        it "管理者権限を持たないユーザーは、newページにアクセスできないこと" do
          visit new_dish_path
          expect(page).to have_content "権限がありません"
        end
      end

      context "管理権限がある場合" do
        before do
          login(admin_user)
          visit new_dish_path
        end

        it "現状登録されている料理IDが表示されていること" do
          expect(page).to have_content "#{dish.id}"
        end

        it "現状登録されている料理名が表示されていること" do
          expect(page).to have_content "#{dish.name}"
        end

        it "料理名・テキストを入力すれば、料理が登録できること" do
          fill_in "dish_name", with: "サンプル"
          fill_in "dish_flavor_text", with: "サンプル料理です"
          click_on "作成する"
          expect(page).to have_content "サンプル"
        end
      end
    end
  end
end
