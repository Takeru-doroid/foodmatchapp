class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @posts = @user.posts
    else
      redirect_to root_path, alert: "無効なアクセスです"
    end
  end
end
