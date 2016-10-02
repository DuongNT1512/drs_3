class DivisionPolicy < ApplicationPolicy
  attr_reader :user, :division

  def initialize current_user, division
    @user = current_user
    @division = division
  end

  def new?
    @user.admin?
  end

  def create?
    @user.admin?
  end

  def index?
    @user.present?
  end

  def update?
    @user.admin?
  end

  def destroy?
    @user.admin?
  end
end
