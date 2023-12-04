require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Postモデル" do
    let(:post) { create(:post) }

    context "Postの登録ができる場合" do
      it "Postに問題がないこと" do
        expect(post).to be_valid
      end
    end

    context "Postの登録ができない場合" do
      it "titleが空であれば登録できないこと" do
        post.title = ""
        post.valid?
        expect(post.errors.full_messages).to include "タイトルを入力してください"
      end

      it "bodyが空であれば登録できないこと" do
        post.body = ""
        post.valid?
        expect(post.errors.full_messages).to include "投稿する内容を入力してください"
      end

      it "user_idが空であれば登録できないこと" do
        post.user_id = ""
        post.valid?
        expect(post.errors.full_messages).to include "ユーザーと紐付けてください"
      end

      it "dish_idが空であれば登録できないこと" do
        post.dish_id = ""
        post.valid?
        expect(post.errors.full_messages).to include "料理と紐付けてください"
      end
    end
  end
end
