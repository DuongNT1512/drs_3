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

  def index?
    current_user.admin?
  end
end
