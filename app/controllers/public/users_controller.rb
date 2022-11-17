class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: [:favorites]

  def index
    @users = User.page(params[:page]).per(10).reverse_order
    @users = @users.where('name LIKE ?', "%#{params[:search]}%") if params[:search].present?
  end

  def show
    @user = User.find(params[:id])
    user_ids = @user.following_user.pluck(:id) # フォローしているユーザーのid一覧
    user_ids.push(@user.id) # 自身のidを一覧に追加する
    @posts = Post.where(user_id: user_ids).order(created_at: :desc).page(params[:page]).per(10).reverse_order
    @following_users = @user.following_user
    @follower_users = @user.follower_user
    gon.Favorite_data = @user.circle_data(@user) #ここで代入したデータをJavaScriptに渡す

  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorites_posts = Kaminari.paginate_array(Post.find(favorites)).page(params[:page]).per(5)
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

  def set_user
    @user = User.find(params[:id])
  end

end
