class Admin::ReportsController < ApplicationController
  after_action :verify_authorized

  def index
    authorize User
    authorize Report
    @working_days = Report.working_days
    @progresses = Progress.all
    @search = Report.includes(:user, :progress).search params[:q]
    @reports = @search.result.paginate page: params[:page], per_page: Settings.page
  end
end
