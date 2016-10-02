class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
  def after_sign_in_path_for current_user
    if current_user.admin?
      admin_root_path
    elsif current_user.manager?
      manager_root_path
    else
      root_path
    end
  end

  def user_not_authorized
    flash[:error] = t "notification.not_admin"
    redirect_to request.referrer || new_user_session_path
  end

  def verify_admin
    unless current_user.admin?
      flash[:error] = t "notification.not_admin"
      if current_user.manager?
        redirect_to manager_root_path
      else
        redirect_to root_path
      end
    end
  end

  def verify_manager
    unless current_user.manager?
      flash[:error] = t "notification.not_admin"
      if current_user.admin?
        redirect_to admin_root_path
      else
        redirect_to root_path
      end
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
  end
end
