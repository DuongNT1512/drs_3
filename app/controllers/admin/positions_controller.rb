class Admin::PositionsController < ApplicationController
  before_action :verify_admin
  after_action :verify_authorized
  before_action :find_position, except: [:index, :new]

  def index
    @search = Position.search params[:q]
    @positions = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize User
  end

  def show
    authorize current_user
    @search = @position.users.search params[:q]
    @users = @search.result.paginate page: params[:page], per_page: Settings.page
  end

  def create
    authorize current_user
    authorize @position
    if @position.save
      flash[:success] = t :create_success
      redirect_to admin_positions_path
    else
      @positions = Position.paginate page: params[:page], per_page: Settings.page
      render :index
    end
  end

  def edit
    authorize current_user
    authorize @position
  end

  def update
    authorize current_user
    authorize @position
    if @position.update_attributes position_params
      flash.now[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to admin_positions_path
  end

  def destroy
    authorize current_user
    authorize @position
    if @position.destroy
      flash[:success] = t "position.delete"
    else
      flash[:danger] = t "position.delete_fail"
    end
    redirect_to admin_positions_path
  end

  private
  def position_params
    params.require(:position).permit :name
  end

  def find_position
    @position = Position.find_by id: params[:id]
    if @position.nil?
      flash[:danger] = t "empty"
      redirect_to admin_positions_path
    end
  end
end
