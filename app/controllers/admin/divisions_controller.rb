class Admin::DivisionsController < ApplicationController
  before_action :find_division, except: [:index, :new, :create]
  before_action :verify_admin
  after_action :verify_authorized

  def index
    @search = Division.search params[:q]
    @divisions = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize User
    authorize Division
  end

  def new
    authorize User
    authorize Division
    @division = Division.new
  end

  def create
    @division = Division.new division_params
    if @division.save
      flash[:success] = t "success"
      redirect_to admin_divisions_path
    else
      flash[:danger] = t "fail"
      render :new
    end
    authorize Division
  end

  def edit
    authorize current_user
    authorize @division
  end

  def show
    authorize current_user
    @search = @division.users.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.page
    @managers = User.all_manager
  end

  def update
    authorize current_user
    authorize @division
    if @division.update_attributes division_params
      flash.now[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to admin_divisions_path
  end

  def destroy
    authorize Division
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
