class Public::FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @params = params[:reaction]
    favorite = current_user.favorites.new(post_id: post.id,reaction: @params)
    favorite.save
    post.create_notification_favorite!(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    redirect_to posts_path
  end



end
