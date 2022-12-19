class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      post.create_notification_post_comment!(current_user, comment.id)
      flash[:notice] = "コメントを投稿しました。"
      redirect_to post_path(post)
    else
      @post = Post.find(params[:post_id])
      @post_comment = PostComment.new
      @post_comments = @post.post_comments.page(params[:page]).per(10).reverse_order
      flash[:alert] = "投稿内容がありませんでした。"
      redirect_to request.referrer
    end
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to request.referrer
  end

  
  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:image)
  end
end
