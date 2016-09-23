class RequestsController < ApplicationController
  before_action :find_request, except: [:new, :create, :index]
  before_action :load_request_kind , only: [:new, :edit]

  def new
    @request = Request.new
  end

  def create
    @request = current_user.request.new request_params
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
    @requests = current_user.request.all.paginate page: params[:page],
      per_page: Settings.request_page
  end

  def edit
  end

  def update
    if @request.update_attributes request_params
      flash.now[:success] = t "request.update_success"
    else
      load_request_kind
      flash[:danger] = t "request.update_fail"
    end
    redirect_to requests_path
  end

  def destroy
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
    @request = current_user.request.find_by_id params[:id]
    if @request.nil?
      flash[:danger] = t "notice.not_lesson"
      redirect_to requests_path
    end
  end

  def load_request_kind
    @request_kinds = Request.request_kinds.keys
  end
end
