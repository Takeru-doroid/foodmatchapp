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
  end
end
