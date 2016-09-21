class RequestsController < ApplicationController
  before_action :find_request, except: [:new, :create, :index]

  def new
    @kind = Request.kinds.keys
    @request = Request.new
  end

  def create
    @request = current_user.request.new request_params
    if @request.save
      flash[:success] = t ("request.create_success")
      redirect_to requests_path
    else
      flash[:danger] = t ("request.create_success")
      @kind = Request.kinds.keys
      render :new
    end
  end

  def index
    @requests = current_user.request.all.paginate page: params[:page],
      per_page: per_page: Settings.request_page
  end

  def edit
    @kinds = Request.kinds.keys
  end

  def update
    if @request.update_attributes request_params
      flash.now[:success] = t "request.update_success"
    else
      @kind = User.kinds.keysP
      flash[:danger] = t "request.update_fail"
    end
    redirect_to requests_path
  end

  def destroy
    if @request.destroy
      flash[:success] = t "request.delete"
    else
      flash[:danger] = t "request.delete_fail"
    redirect_to requests_path
  end

  private
  def request_params
    params.require(:request).permit :kind, :date_leave_from, :date_leave_to,
      :compensation_time_to, :compensation_time_from, :reason
  end

  def find_request
    @request = current_user.request.find_by_id params[:id]
    if @request.nil?
      flash[:danger] = t "notice.not_lesson"
      redirect_to requests_path
    end
  end
end
