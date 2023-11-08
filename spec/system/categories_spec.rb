require 'rails_helper'

RSpec.describe Category, type: :system do
  describe "categories" do
    let(:user) { create(:user) }
    let!(:category) { create(:category, id: 1, name: "キノコ類") }
    before { login(user) }

    describe "newページ" do
      before do
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
