class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
    @post1 = Post.find(8)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:content,:image)
  end

end
