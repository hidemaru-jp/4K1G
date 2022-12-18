class Admin::PostCommentsController < ApplicationController
  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    flash[:notice] = "コメントを削除しました。"
    redirect_to admin_post_path(post_comment.post_id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment,:image)
  end

end
