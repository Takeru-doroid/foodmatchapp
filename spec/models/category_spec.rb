require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Categoryモデル" do
    let(:category) { create(:category) }

    context "Categoryの登録ができる場合" do
      it "カテゴリ情報に問題がないこと" do
        expect(category).to be_valid
      end
    end

    context "Categoryの登録ができない場合" do
      it "nameが空であれば登録できないこと" do
        category.name = ""
        category.valid?
        expect(category.errors.full_messages).to include "カテゴリ名を入力してください"
      end
    end
  end
end
