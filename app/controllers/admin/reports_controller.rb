class Admin::ReportsController < ApplicationController
  def index
    binding.pry
    @search = Report.search params[:report]
    @reports = @search.result.paginate page: params[:page], per_page: Settings.page
    @search.build_condition
  end

  private
  def report_params
    params.require(:report).permit :division_id, :language_id, :working_day,
      :progress_id, :achievement
  end
end
