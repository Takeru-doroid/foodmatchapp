require 'rails_helper'

RSpec.describe Category, type: :system do
  describe "categories" do
    let(:user) { create(:user) }
    let(:admin_user) { create(:user, role: 1) }
    let!(:category) { create(:category, id: 1, name: "キノコ類") }

    describe "newページ" do
      context "管理者権限を持たない場合" do
        before { login(user) }

        it "管理者権限を持たないユーザーは、newページにアクセスできないこと" do
          visit new_category_path
          expect(page).to have_content "権限がありません"
        end
      end

      context "管理者権限を持つ場合" do
        before do
          login(admin_user)
          visit new_category_path
        end

        it "現状登録されているカテゴリIDが表示されていること" do
          expect(page).to have_content "#{category.id}"
        end

        it "現状登録されているカテゴリ名が表示されていること" do
          expect(page).to have_content "#{category.name}"
        end

        it "カテゴリ名を入力すれば、カテゴリが登録できること" do
          fill_in "category_name", with: "サンプル"
          click_on "作成する"
          expect(page).to have_content "サンプル"
        end
      end
    end
  end
end
