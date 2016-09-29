class ReportPolicy < ApplicationPolicy
  attr_reader :user, :request

  def initialize current_user, request
    @user = current_user
    @request = request
  end

  def new?
    @user.employee?
  end

  def create?
    new?
  end

  def index?
    @user.present?
  end

  def update?
    if @user.employee?
      [:division_id, :language_id, :working_day, :progress_id, :achievement]
    else
      flash[:danger] = t "not_admin"
      redirect_to root_path
    end
  end
end
