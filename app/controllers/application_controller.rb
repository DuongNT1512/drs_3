class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticate_user!
  protect_from_forgery with: :exception

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
end
