class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    user_posts = @user.posts
    post_favorites_count = 0
    user_posts.each do |post|
      post_favorites_count += post.favorites.size
    end
    @post_favorites_count = post_favorites_count
    if @user.id == current_user.id
      @posts = @user.posts
    else
      redirect_to root_path, alert: "無効なアクセスです"
    end
  end
end
