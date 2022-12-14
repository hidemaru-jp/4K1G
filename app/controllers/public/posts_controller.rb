class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.eager_load(:user).preload(:favorites,:post_comments).page(params[:page]).per(10).reverse_order
    @post = Post.new
    @posts = @posts.eager_load(:user).preload(:favorites,:post_comments).where('content LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @post = Post.eager_load(:user).preload(:post_comments).find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(10).reverse_order
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to posts_path
    else
      @posts = Post.page(params[:page]).per(10).reverse_order
      @post = Post.new
      @posts = @posts.where('content LIKE ?', "%#{params[:search]}%") if params[:search].present?
      flash[:alert] = "投稿できませんでした。"
      render :index
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to request.referrer
  end

  
  private

  def post_params
    params.require(:post).permit(:content,:image)
  end

end
