class ReportsController < ApplicationController
  before_action :find_report, only: :update
  after_action :verify_authorized

  def index
    authorize Report
    @reports = current_user.reports.all.paginate page: params[:page],
      per_page: Settings.request_page
    authorize User
  end

  def new
    authorize current_user
    @working_day = Report.working_days.keys
    load_data
    @report = Report.new
    authorize @report
  end

  def create
    authorize current_user
    authorize @report
    @report = current_user.reports.new report_params
    binding.pry
    if @report.save
      flash[:success] = t "report.create_success"
      redirect_to reports_path
    else
      load_data
      @working_day = Report.working_days.keys
      flash[:danger] = t "report.create_fail"
      render :new
    end
  end

  def update
    authorize current_user
    authorize @report

    if @report.update_attributes report_params
      flash.now[:success] = t "report.update_success"
    else
      load_report_working_day
      flash[:danger] = t "report.update_fail"
    end
    redirect_to reports_path
  end

  private
  def find_report
    @report = current_user.reports.find_by id: params[:id]
    if @report.nil?
      flash[:danger] = t "notice.not_report"
      redirect_to reports_path
    end
  end

  def report_params
    params.require(:report).permit :division_id, :language_id, :working_day,
      :progress_id, :achievement
  end

  def load_data
    Settings.namemodel.each do |name|
      instance_variable_set "@#{name}s".capitalize, "#{name.capitalize}".constantize.all
    end
  end
end
