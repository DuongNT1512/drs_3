class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def create
    @user = User.from_omniauth request.env["omniauth.auth"]
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      if is_navigational_format?
        set_flash_message :notice, :success,
          kind: "#{request.env["omniauth.auth"]["provider"]}"
      end
    else
      session["devise.#{request.env["omniauth.auth"]["provider"]}_data"] =
        request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def show
    redirect_to root_path
  end

  alias_method :facebook, :create
  alias_method :google_oauth2, :create
  alias_method :failure, :show
end
