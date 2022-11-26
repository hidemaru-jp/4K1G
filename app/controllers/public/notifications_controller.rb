class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(check: false).each do |notification|
      notification.update(check: true)
    end
  end

  def destroy_all
    notifications = current_user.passive_notifications
    notifications.destroy_all
    redirect_to request.referrer
  end

  include Public::NotificationsHelper

end
