class Admin::DivisionsController < ApplicationController
  after_action :verify_authorized
  before_action :find_division, except: [:index, :new]
    before_action :verify_admin

  def index
    @search = Division.search params[:q]
    @divisions = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize User
  end

  def new
    authorize User
    @division = Division.new
    authorize Request
  end

  def create
    authorize current_user
    @division = Division.new request_params
    if @division.save
      flash[:success] = t "success"
      redirect_to admin_divisions_path
    else
      flash[:danger] = t "fail"
      render :new
    end
  end

  def show
    authorize current_user
    @search = @division.users.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.page
    @managers = User.all_manager
  end

  def update
    authorize current_user
    if @division.update_attributes division_params
      flash.now[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to admin_divisions_path
  end

  def destroy
    authorize @division
    if @division.destroy
      flash[:success] = t "request.delete"
    else
      flash[:danger] = t "request.delete_fail"
    end
    redirect_to admin_divisions_path
  end

  private
  def division_params
    params.require(:division).permit :name
  end

  def find_division
    @division = Division.find_by id: params[:id]
    if @division.nil?
      flash[:danger] = t "division.empty"
      redirect_to admin_divisions_path
    end
  end
end
