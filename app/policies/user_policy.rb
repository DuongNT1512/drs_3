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
    @user.present?
  end

  def show?
    @user.present?
  end

  def update?
    if @user.admin?
      [:role, :position_id]
    elsif @user.manager?
      [:division_id, :language_id]
    elsif current_user? user
      [:username, :password]
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

  def destroy?
    new?
  end

  private
  def verify_admin
    @user.admin?
  end

  def verify_manager
    @user.manager?
  end
end
