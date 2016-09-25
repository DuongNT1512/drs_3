class Manager::ReportsController < ApplicationController
  before_action :find_report, only: :update
  after_action :verify_authorized

  def index
    @reports = Report.all.paginate page: params[:page],
      per_page: Settings.page
    authorize User
  end

  private
  def find_report
    @report = Report.find_by_id params[:id]
    if @report.nil?
      flash[:danger] = t "report.empty"
      redirect_to manager_reports_path
    end
  end
end
