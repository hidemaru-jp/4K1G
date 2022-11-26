class Admin::PostsController < ApplicationController

	def index
    @posts = Post.page(params[:page]).per(10).reverse_order
    @post = Post.new
    @posts = @posts.where('content LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = @post.post_comments
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content,:image)
  end

end
