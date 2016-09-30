class Manager::ReportController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Report
    @reports = Report.request_init.paginate page: params[:page],
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
