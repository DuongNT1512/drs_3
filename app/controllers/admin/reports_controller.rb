class Admin::ReportsController < ApplicationController
  def index
    @reports = Report.all.paginate page: params[:page], per_page: Settings.page
  end
end
