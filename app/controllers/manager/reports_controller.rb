class Manager::RequestsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Report

    @working_days = Report.working_days
    @progresses = Progress.all
    @search = Report.includes(:user, :progress).request_init.search params[:q]
    @reports = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize User
  end
end
