module LoginModule
  def login(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    within ".actions" do
      click_on "ログイン"
    end
  end
end
