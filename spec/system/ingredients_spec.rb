require 'rails_helper'

RSpec.describe Ingredient, type: :system do
  describe "ingredients" do
    let(:user) { create(:user) }
    let!(:ingredient) { create(:ingredient, name: "ソラダケ", category: category) }
    let!(:category) { create(:category, id: 1, name: "キノコ類") }
    before { login(user) }

    describe "indexページ" do
      before do
        visit ingredients_path
      end

      it "食材画像が表示されていること" do
        expect(page).to have_selector "img[alt=#{ingredient.name}の画像]"
      end

      it "食材名が詳細ページへのリンクになっていること" do
        click_on "#{ingredient.name}"
        expect(current_path).to eq ingredient_path(ingredient)
      end

      it "食材のカテゴリ名が表示されていること" do
        expect(page).to have_content "#{category.name}"
      end
    end

    describe "showページ" do
      before do
        visit ingredient_path(ingredient)
      end

      it "食材画像が表示されていること" do
        expect(page).to have_selector "img[alt=#{ingredient.name}の画像]"
      end

      it "食材のカテゴリ名が表示されていること" do
        expect(page).to have_content "#{category.name}"
      end

      it "flavor_textが表示されていること" do
        expect(page).to have_content "#{ingredient.flavor_text}"
      end
    end

    describe "newページ" do
      before do
        visit new_ingredient_path
      end

      it "現状登録されている食材IDが表示されていること" do
        expect(page).to have_content "#{ingredient.id}"
      end

      it "現状登録されている食材が表示されていること" do
        expect(page).to have_content "#{ingredient.name}"
      end

      it "食材名・テキストを入力、紐付けカテゴリを選択すれば、食材が登録できること" do
        fill_in "ingredient_name", with: "サンプル"
        fill_in "ingredient_flavor_text", with: "サンプルです"
        select "キノコ類", from: "ingredient_category_id"
        click_on "作成する"
        expect(page).to have_content "サンプル"
      end
    end
  end
end
