class languagePolicy < ApplicationPolicy
  attr_reader :user, :language

  def initialize current_user, language
    @user = current_user
    @language = language
  end

  def new?
    @user.admin?
  end

  def create?
    new?
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
