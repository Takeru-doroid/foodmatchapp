require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Userモデル" do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }

    context "新規登録ができる場合" do
      it "新規ユーザーの情報に問題がないこと" do
        expect(user).to be_valid
      end
    end

    context "新規登録ができない場合" do
      it "nameが空であれば登録できないこと" do
        user.name = ""
        user.valid?
        expect(user.errors.full_messages).to include "ユーザー名を入力してください"
      end

      it "emailが空であれば登録できないこと" do
        user.email = ""
        user.valid?
        expect(user.errors.full_messages).to include "Eメールを入力してください"
      end

      it "emailが重複していれば登録できないこと" do
        user.save
        another_user.email = user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Eメールはすでに存在します"
      end

      it "emailが正規表現に合致しないものであれは登録できないこと" do
        user.email = "aaa@aaa"
        user.valid?
        expect(user.errors.full_messages).to include "Eメールが不正な値です"
      end

      it "passwordが空であれば登録できないこと" do
        user.password = ""
        user.valid?
        expect(user.errors.full_messages).to include "パスワードを入力してください"
      end

      it "passwordが5文字以下であれば登録できないこと" do
        user.password = "12345"
        user.password_confirmation = "12345"
        user.valid?
        expect(user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
      end

      it "passwordが129文字以上であれば登録できないこと" do
        user.password = "1" + "a" * 129
        user.password_confirmation = "a" * 129
        user.valid?
        expect(user.errors.full_messages).to include "パスワードは128文字以内で入力してください"
      end

      it "passwordが半角英数字それぞれ1文字以上含まなければ登録できないこと" do
        user.password = "aaaaaaaa"
        user.valid?
        expect(user.errors.full_messages).to include "パスワードは半角英字・半角数字をそれぞれ1文字以上含む必要があります"
      end

      it "passwordが存在しても、確認用パスワードが空であれば登録できないこと" do
        user.password_confirmation = ""
        user.valid?
        expect(user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
    end
  end
end
