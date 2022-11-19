class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    post.create_notification_post_comment!(current_user, comment.id)
    redirect_to post_path(post)
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_to post_path(post_comment.post_id)
  end



  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:image)
  end
end
