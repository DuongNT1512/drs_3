class RequestPolicy < ApplicationPolicy
  attr_reader :user, :request

  def initialize current_user, request
    @user = current_user
    @request = request
  end

  def destroy?
    user_is_owner_of_record
  end

  def new?
    @user.employee?
  end

  def edit?
    update?
  end

  def index?
    @user.manager? || user_is_owner_of_record?
  end

  def update?
    if @user.manager?
      [:approved]
    elsif user_is_owner_of_record?
      [:request_kind, :date_leave_from, :date_leave_to,
      :compensation_time_from, :compensation_time_to, :reason]
    else
      flash[:danger] = t "not_admin"
      redirect_to root_path
    end
  end

  private
  def user_is_owner_of_record?
    @user == @request.user
  end
end
