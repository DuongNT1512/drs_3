class Manager::RequestsController < ApplicationController
  before_action :find_request, only: :update
  after_action :verify_authorized

  def index
    @requests = Request.request_init.paginate page: params[:page],
      per_page: Settings.page
    authorize User
  end

  private
  def find_request
    @request = Request.find_by_id params[:id]
    if @request.nil?
      flash[:danger] = t "request.empty"
      redirect_to manager_requests_path
    end
  end
end
