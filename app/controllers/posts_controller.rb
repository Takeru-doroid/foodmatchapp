class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user, dish: { image_attachment: :blob }).all
  end

  def new
    if params[:dish_id].present?
      @post = Post.new
      @post.dish_id = params[:dish_id]
    else
      redirect_to root_path, alert: "無効なアクセスです"
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "投稿しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user.id == current_user.id
      if params[:dish_id].present?
        @post.dish_id = params[:dish_id]
      else
        redirect_to posts_path, alert: "無効なアクセスです"
      end
    else
      redirect_to posts_path, alert: "無効なアクセスです"
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    if @post.update(post_params)
      redirect_to posts_path, notice: "編集しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: "投稿を削除しました", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, :dish_id)
  end
end
