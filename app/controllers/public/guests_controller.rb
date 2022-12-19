class Public::GuestsController < ApplicationController

  def new_guest
    user = User.find_or_create_by!(name: 'guest',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to user_path(current_user), notice: 'ゲストユーザーとしてログインしました。'
  end

end
