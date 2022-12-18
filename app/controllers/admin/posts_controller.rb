class Admin::PostsController < ApplicationController

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
