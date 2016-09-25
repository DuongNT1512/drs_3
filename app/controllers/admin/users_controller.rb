class Admin::UsersController < ApplicationController
  before_action :find_user, except: [:index, :new, :create]
  after_action :verify_authorized

  def index
    @users = User.all.paginate page: params[:page], per_page: Settings.page
    authorize User
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
    load_data
  end

  def update
    authorize @user
    if @user.update_attributes user_params
      if @user.check_manager
        @user.manager!
        flash[:success] = t "notification.success"
        redirect_to admin_users_path
      end
    else
      flash[:danger] = t "notification.fail"
      render :edit
    end
  end

  def destroy
    authorize @user
    if @user.destroy
      flash[:success] = t "notification.destroy_success"
    else
      flash[:danger] = t "notification.destroy_fail"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :position_id, :division_id, :role
  end

  def load_data
    Settings.model.each do |name|
      instance_variable_set "@#{name}s".capitalize, "#{name.capitalize}".constantize.all
    end
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "user.empty"
      redirect_to admin_users_path
    end
  end
end
