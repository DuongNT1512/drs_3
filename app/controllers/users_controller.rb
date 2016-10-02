class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]

  def show
  end

  def index
    load_data
    @search = User.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.page
  end

  def edit

  end

  def update
    authorize current_user
    if @user.update_attributes user_params
      flash.now[:success] = t "request.update_success"
      redirect_to users_path
    else
      flash[:danger] = t "request.update_fail"
      render :edit
    end
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

  def user_params
    params.require(:user).permit :username, :email
  end
end
