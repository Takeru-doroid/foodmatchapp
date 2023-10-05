require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Categoryモデル" do
    let(:category) { create(:category) }

    context "カテゴリの登録ができる場合" do
      it "カテゴリ情報に問題ない時、有効なこと" do
        expect(category).to be_valid
      end
    end

    context "カテゴリの登録ができない場合" do
      it "nameが空の時、無効なこと" do
        category.name = ""
        expect(category).to be_invalid
      end
    end
  end
end
