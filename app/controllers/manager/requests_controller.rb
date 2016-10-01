class Manager::RequestsController < ApplicationController
  before_action :find_request, only: :update
  after_action :verify_authorized
  before_action :verify_manager

  def index
    @request_kinds = Request.request_kinds
    @requests = Request.all_division current_user.division_id
    @search = @requests.includes(:user).search params[:q]
    @requests = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize current_user
  end

  def update
    authorize current_user
    if @request.update_attributes request_params
      flash[:success] = t "notification.success"
    else
      flash[:danger] = t "notification.fail"
    end
    authorize @request
    redirect_to manager_requests_path
  end

  private
  def request_params
    params.require(:request).permit :approved
  end

  def find_request
    @request = Request.find_by_id params[:id]
    if @request.nil?
      flash[:danger] = t "request.empty"
      redirect_to manager_requests_path
    end
  end
end
