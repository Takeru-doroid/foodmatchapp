require 'rails_helper'

RSpec.describe User, type: :system do
  describe "User CRUD" do
    let(:user) { create(:user) }
    let!(:guest_user) { create(:user, name: "ゲストユーザー", email: "guest@example.com") }
    let!(:dish) { create(:dish) }
    let!(:posts) { create_list(:post, 2, user: user, dish: dish) }

    before do
      visit root_path
    end

    describe "ヘッダーアクション" do
      it "トップ画面に遷移できること" do
        find("#root-path").click
        expect(current_path).to eq root_path
      end

      it "新規登録画面に遷移できること" do
        find("#new-user-registration-path").click
        expect(current_path).to eq new_user_registration_path
      end

      it "ログイン画面に遷移できること" do
        find("#login-path").click
        expect(current_path).to eq new_user_session_path
      end

      it "ゲストログインができること" do
        find("#guest-login-path").click
        expect(page).to have_content "ゲストユーザーとしてログインしました。"
      end

      it "ゲストユーザーは編集・更新ができないこと" do
        find("#guest-login-path").click
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

      it "投稿一覧のリンク先がposts_pathになること" do
        find("#posts-path").click
        expect(current_path).to eq posts_path
      end

      it "組み合わせのリンク先がselections_display_selection_pathになること" do
        find("#selections-display-selection-path").click
        expect(current_path).to eq selections_display_selection_path
      end

      it "食材一覧のリンク先がingredients_pathになること" do
        find("#ingredients-path").click
        expect(current_path).to eq ingredients_path
      end

      it "ログアウトリンクをクリックするとログアウトできること" do
        find("#logout-path").click
        expect(page).to have_selector "#navbarLogoutUserContent"
      end

      it "デフォルトのアバター画像が表示されていること" do
        expect(page).to have_selector "img[alt='デフォルトのアバター画像']"
      end

      it "デフォルトのアバターをクリックすると詳細画面に遷移できること" do
        click_on "デフォルトのアバター画像"
        expect(current_path).to eq user_path(user)
      end

      it ".fa-bellアイコンをクリックするとユーザーの通知一覧に遷移できること" do
        find("#user-notifications-path").click
        expect(current_path).to eq user_notifications_path(user)
      end

      describe "showページ" do
        before do
          visit user_path(user)
        end

        it "ユーザー情報変更が編集ページへのリンクになっていること" do
          click_on "ユーザー情報変更"
          expect(current_path).to eq edit_user_registration_path
        end

        it "自分の全投稿が表示されていること" do
          expect(Post.count).to eq 2
          within ".my-posts-container" do
            posts.each_with_index do |post, i|
              expect(page).to have_css ".my-post-#{i}"
            end
          end
        end

        it "投稿のtitle・body・作成日が表示されていること" do
          within ".my-posts-container" do
            posts.each do |post|
              expect(page).to have_content "#{post.title}"
              expect(page).to have_content "#{post.body}"
              expect(page).to have_content "#{post.created_at.to_formatted_s(:datetime_jp)}"
            end
          end
        end

        it "投稿に紐付けられる料理名・料理画像が表示されていること" do
          within ".my-posts-container" do
            posts.each do |post|
              expect(page).to have_content "#{post.dish.name}"
              expect(page).to have_selector "img[alt=#{post.dish.name}の画像]"
            end
          end
        end

        it "投稿にいいねのON/OFFができること" do
          within ".my-post-0" do
            click_on "いいね"
            expect(Favorite.count).to eq 1
            click_on "いいね"
            expect(Favorite.count).to eq 0
          end
        end

        it "編集するが投稿編集ページへのリンクになっていること" do
          within ".my-posts-container" do
            within ".my-post-0" do
              click_on "編集する"
              expect(current_path).to eq edit_post_path(posts[0].id)
            end
          end
        end

        it "他ユーザーは、詳細ページにアクセスできないこと" do
          find("#logout-path").click
          login(guest_user)
          visit user_path(user)
          expect(page).to have_content "無効なアクセスです"
        end
      end

      describe "editページ" do
        before do
          visit edit_user_registration_path
        end

        it "ユーザー編集ができること" do
          fill_in "user_current_password", with: user.password
          click_on "更新する"
          expect(current_path).to eq root_path
          expect(page).to have_content "アカウント情報を変更しました。"
        end

        it "アバター画像の更新ができること" do
          fill_in "user_current_password", with: user.password
          attach_file("user[avatar]", Rails.root.join("app/assets/images/test_sample.jpg"))
          click_on "更新する"
          expect(current_path).to eq root_path
          expect(page).to have_selector "img[alt='ユーザーのアバター画像']"
        end

        it "現在のパスワードを入力しなければ編集できないこと" do
          click_on "更新する"
          expect(page).to have_content "現在のパスワードを入力してください"
        end
      end
    end
  end
end
