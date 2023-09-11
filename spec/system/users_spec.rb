require 'rails_helper'

RSpec.describe User, type: :system do
  describe "User CRUD" do
    let(:user) { create(:user) }
    let!(:guest_user) { create(:user, name: "ゲストユーザー", email: "guest@example.com") }

    before do
      visit root_path
    end

    describe "ヘッダーアクション" do
      it "トップ画面に遷移できること" do
        find(".fa-house").click
        expect(current_path).to eq root_path
      end

      it "新規登録画面に遷移できること" do
        click_on "新規登録"
        expect(current_path).to eq new_user_registration_path
      end

      it "ログイン画面に遷移できること" do
        click_on "ログイン"
        expect(current_path).to eq new_user_session_path
      end

      it "ゲストログインができること" do
        click_on "ゲストログイン"
        expect(current_path).to eq root_path
        expect(page).to have_content "ゲストユーザーとしてログインしました。"
      end

      it "ゲストユーザーは編集・更新ができないこと" do
        click_on "ゲストログイン"
        visit user_path(guest_user)
        click_on "ユーザー情報変更"
        expect(page).to have_content "ゲストユーザーの更新・削除はできません。"
      end
    end

    describe "ログイン前" do
      it "新規登録できること" do
        visit new_user_registration_path
        fill_in "user_name", with: "system user"
        fill_in "user_email", with: "system@mail.com"
        fill_in "user_password", with: "sytem123"
        fill_in "user_password_confirmation", with: "sytem123"
        click_on "登録する"
        expect(current_path).to eq root_path
        expect(page).to have_content "アカウント登録が完了しました。"
      end

      it "アイコンのクリックでパスワードの表示/非表示が切り替えれること" do
        visit new_user_registration_path
        expect(page).to have_selector "input[type='password']"
        find("#toggle-password-icon").click
        expect(page).to have_selector "input[type='text']"
      end

      it "ログインできること" do
        login(user)
        expect(current_path).to eq root_path
        expect(page).to have_content "ログインしました。"
      end
    end

    describe "ログイン後" do
      before { login(user) }

      it "デフォルトのアバター画像が表示されていること" do
        expect(page).to have_selector "img[alt='デフォルトのアバター画像']"
      end

      it "デフォルトのアバターをクリックすると詳細画面に遷移できること" do
        click_on "デフォルトのアバター画像"
        expect(current_path).to eq user_path(user)
      end

      it "編集画面に遷移できること" do
        visit user_path(user)
        click_on "ユーザー情報変更"
        expect(current_path).to eq edit_user_registration_path
      end

      it "アイコンのクリックでパスワードの表示/非表示が切り替えれること" do
        visit edit_user_registration_path
        expect(page).to have_selector "input[type='password']"
        find("#toggle-password-icon").click
        expect(page).to have_selector "input[type='text']"
      end

      it "ユーザー編集ができること" do
        visit edit_user_registration_path
        fill_in "user_current_password", with: user.password
        click_on "更新する"
        expect(current_path).to eq root_path
        expect(page).to have_content "アカウント情報を変更しました。"
      end

      it "アバター画像の更新ができること" do
        visit edit_user_registration_path
        fill_in "user_current_password", with: user.password
        attach_file("user[avatar]", Rails.root.join("app/assets/images/test_sample.jpg"))
        click_on "更新する"
        expect(current_path).to eq root_path
        expect(page).to have_selector "img[alt='ユーザーのアバター画像']"
      end

      it "現在のパスワードを入力しなければ編集できないこと" do
        visit edit_user_registration_path
        click_on "更新する"
        expect(page).to have_content "現在のパスワードを入力してください"
      end
    end
  end
end
