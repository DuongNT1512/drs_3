class Manager::ReportsController < ApplicationController
  after_action :verify_authorized
  before_action :verify_manager

  def index
    authorize Report
    @working_days = Report.working_days
    @progresses = Progress.all
    @reports = Report.all_division current_user.division_id
    @search = @reports.includes(:user, :progress).search params[:q]
    @reports = @search.result.paginate page: params[:page], per_page: Settings.page
    authorize User
  end
end
