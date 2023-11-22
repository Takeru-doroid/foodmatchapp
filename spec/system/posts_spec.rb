require 'rails_helper'

RSpec.describe Post, type: :system do
  describe "Post" do
    let(:user) { create(:user) }
    let!(:guest_user) { create(:user, name: "ゲストユーザー", email: "guest@example.com") }
    let!(:dish) { create(:dish) }
    let!(:posts) { create_list(:post, 2, user: user, dish: dish) }

    describe "indexページ" do
      before do
        login(user)
        visit posts_path
      end

      it "投稿のtitle・body・作成日が表示されていること" do
        within ".posts-container" do
          posts.each do |post|
            expect(page).to have_content "#{post.title}"
            expect(page).to have_content "#{post.body}"
            expect(page).to have_content "#{post.created_at.to_formatted_s(:datetime_jp)}"
          end
        end
      end

      it "投稿ユーザーが表示されていること" do
        within ".posts-container" do
          posts.each do |post|
            expect(page).to have_content "#{post.user.name}"
          end
        end
      end

      it "投稿に紐付けられる料理名・料理画像が表示されていること" do
        within ".posts-container" do
          posts.each do |post|
            expect(page).to have_content "#{post.dish.name}"
            expect(page).to have_selector "img[alt=#{post.dish.name}の画像]"
          end
        end
      end

      it "全ての投稿が表示されていること" do
        expect(Post.count).to eq 2
        within ".posts-container" do
          posts.each_with_index do |post, i|
            expect(page).to have_css ".post-#{i}"
          end
        end
      end

      it "自分の投稿に、編集ページへのリンクがあること" do
        within ".posts-container" do
          within ".post-0" do
            click_on "編集する"
            expect(current_path).to eq edit_post_path(posts[0].id)
          end
        end
      end

      it "投稿ユーザー以外には、編集ページへのリンクが表示されないこと" do
        click_on "ログアウト"
        login(guest_user)
        visit posts_path
        within ".posts-container" do
          expect(page).to_not have_link "編集する"
        end
      end
    end

    describe "newページ" do
      before { login(user) }

      context "newページに遷移できない場合" do
        it "dish_idが渡せていなければ、アクセスできないこと" do
          visit new_post_path
          expect(page).to have_content "無効なアクセスです"
        end
      end

      context "newページに遷移できる場合" do
        before do
          visit new_post_path(dish_id: dish.id)
        end

        it "タイトル名・投稿する内容を入力すれば、登録できること" do
          fill_in "post_title", with: "サンプル"
          fill_in "post_body", with: "サンプルです"
          click_on "投稿する"
          expect(page).to have_content "サンプル"
        end
      end
    end

    describe "editページ" do
      context "editページに遷移できない場合" do
        it "別ユーザーは、投稿の編集ページにアクセスできないこと" do
          visit root_path
          click_on "ゲストログイン"
          visit edit_post_path(posts[0].id)
          expect(page).to have_content "無効なアクセスです"
        end

        it "dish_idが渡せていなければ、アクセスできないこと" do
          login(user)
          visit edit_post_path(posts[0].id)
          expect(page).to have_content "無効なアクセスです"
        end
      end

      context "editページに遷移できる場合" do
        before do
          login(user)
          visit edit_post_path(posts[0].id, dish_id: dish.id)
        end

        it "投稿の編集ができること" do
          fill_in "post_title", with: "編集後タイトル"
          click_on "編集する"
          expect(page).to have_content "編集後タイトル"
        end
      end
    end
  end
end
