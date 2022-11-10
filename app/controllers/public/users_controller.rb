class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.page(params[:page]).per(10).reverse_order
    @users = @users.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @user = User.find(params[:id])
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guest"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end


  private

  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end

end
