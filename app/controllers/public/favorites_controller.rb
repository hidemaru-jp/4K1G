class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @reaction = params[:reaction]
    @favorited = params[:favorited_id]
    favorite = current_user.favorites.new(post_id: post.id,reaction: @reaction,favorited_id: @favorited)
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
    redirect_to request.referrer
  end
  
  



end
