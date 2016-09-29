class RequestsController < ApplicationController
  before_action :find_request, except: [:new, :create, :index]
  before_action :load_request_kind , only: [:new, :edit]
  after_action :verify_authorized

  def new
    authorize User
    @request = Request.new
    authorize Request
  end

  def create
    authorize current_user
    @request = current_user.requests.new request_params
    if @request.save
      flash[:success] = t "request.create_success"
      redirect_to requests_path
    else
      load_request_kind
      flash[:danger] = t "request.create_fail"
      render :new
    end
  end

  def index
    @requests = current_user.requests.all.paginate page: params[:page],
      per_page: Settings.request_page
    authorize current_user
  end

  def edit
    authorize current_user
    authorize @request
  end

  def update
    authorize current_user
    authorize @request
    if @request.update_attributes request_params
      flash.now[:success] = t "request.update_success"
    else
      load_request_kind
      flash[:danger] = t "request.update_fail"
    end
    redirect_to requests_path
  end

  def destroy
    authorize @request
    if @request.destroy
      flash[:success] = t "request.delete"
    else
      flash[:danger] = t "request.delete_fail"
    end
    redirect_to requests_path
  end

  private
  def request_params
    params.require(:request).permit :request_kind, :date_leave_from, :date_leave_to,
      :compensation_time_to, :compensation_time_from, :reason
  end

  def find_request
    @request = current_user.requests.find_by_id params[:id]
    if @request.nil?
      flash[:danger] = t "notice.not_lesson"
      redirect_to requests_path
    end
  end

  def load_request_kind
    @request_kinds = Request.request_kinds.keys
  end
end
