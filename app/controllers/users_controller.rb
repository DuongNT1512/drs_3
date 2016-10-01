class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]

  def show
  end

  def index
    load_data
    @search = User.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.page
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      redirect_to root_path
      flash[:danger] = t :user_fails
    end
  end

  def load_data
    Settings.model.each do |name|
      instance_variable_set "@#{name}s".capitalize, "#{name.capitalize}".constantize.all
    end
  end
end
