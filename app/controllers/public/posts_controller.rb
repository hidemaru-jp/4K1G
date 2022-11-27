class Public::PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.page(params[:page]).per(10).reverse_order
    @post = Post.new
    @posts = @posts.where('content LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments.page(params[:page]).per(10).reverse_order
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      @posts = Post.page(params[:page]).per(10).reverse_order
      @post = Post.new
      @posts = @posts.where('content LIKE ?', "%#{params[:search]}%") if params[:search].present?
      render :index
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to request.referrer
  end

  private

  def post_params
    params.require(:post).permit(:content,:image)
  end

end
