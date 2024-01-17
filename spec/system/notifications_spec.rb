require 'rails_helper'

RSpec.describe Notification, type: :system do
  describe "notifications" do
    let(:user) { create(:user) }
    let!(:guest_user) { create(:user, name: "ゲストユーザー", email: "guest@example.com") }
    let!(:dish) { create(:dish) }
    let!(:post) { create(:post, user: user, dish: dish) }

    describe "indexページ" do
      context "通知がある場合" do
        before do
          login(guest_user)
          find("#posts-path").click
          within ".post-0" do
            click_on "いいね"
          end
          find("#logout-path").click
          login(user)
        end

        it "通知アイコン(.fa-bell)に丸アイコン(.fa-circle)が重なること" do
          within "#user-notifications-path" do
            expect(page).to have_css ".fa-circle"
          end
        end

        it "通知一覧ページに遷移すると丸アイコン(.fa-circle)がなくなること" do
          visit user_notifications_path(user)
          within "#user-notifications-path" do
            expect(page).to_not have_css ".fa-circle"
          end
        end

        it "通知が表示されていること" do
          visit user_notifications_path(user)
          expect(page).to have_selector "#notification-body"
        end

        it "通知にはいいねしたユーザー画像が表示されていること" do
          visit user_notifications_path(user)
          within "#notification-body" do
            expect(page).to have_selector "img[alt='デフォルトのアバター画像']"
          end
        end
      end

      context "通知がない場合" do
        before do
          login(user)
        end

        it "通知が表示されていないこと" do
          visit user_notifications_path(user)
          expect(page).to have_content "通知はありません"
        end
      end
    end
  end
end
