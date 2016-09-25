class UserPolicy < ApplicationPolicy
  class Scope
    attr_reader :current_user, :scope

    def initialize current_user, scope
      @current_user = current_user
      @scope = scope
    end

    def resolve
      if current_user.admin?
        scope.all
      else
        flash[:danger] = t "not_admin"
        redirect_to root_path
      end
    end
  end
  def initialize user, scope
    @user = user
    @scope = scope
  end

  def index?
    verify_admin || verify_manager
  end

  def show?
    verify_admin
  end

  def update?
    if @user.admin?
      [:role]
    elsif @user.manager?
      [:division]
    elsif user_is_owner_of_record?
      [:request_kind, :date_leave_from, :date_leave_to,
        :compensation_time_from, :compensation_time_to, :reason]
    end
  end

  def new?
    !verify_manager || !verify_admin
  end

  def edit?
    update?
  end

  def create?
    @user.employee?
  end

  private
  def verify_admin
    @user.admin?
  end

  def verify_manager
    @user.manager?
  end
end
