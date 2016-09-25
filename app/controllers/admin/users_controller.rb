class Admin::UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all.paginate page: params[:page], per_page: Settings.page
    authorize User
  end
end
