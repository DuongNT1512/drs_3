class PositionPolicy < ApplicationPolicy
  attr_reader :user, :position

  def initialize current_user, position
    @user = current_user
    @position = position
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

  def edit?
    @user.admin?
  end
end
