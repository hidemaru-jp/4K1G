class ApplicationController < ActionController::Base
  before_action :authenticate_admin!, if: :admin_url
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def admin_url
    request.fullpath.include?("/admin")
  end

  def authenticate_admin
    if @current_admin == nil
      redirect_to("/admin/sign_in")
    end
  end

  def authenticate_user
    if @current_user == nil
      redirect_to("/users/sign_in")
    end
  end


end
