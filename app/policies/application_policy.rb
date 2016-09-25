class ApplicationPolicy
  attr_reader :current_user, :model

  def initialize current_user, model
    raise Pundit::NotAuthorizedError, I18n.t("notification.login") unless current_user
    @current_user = current_user
    @record = model
  end

  def index
    @current_user.admin?
  end

  def show
    scope.where(id: model.id).exists?
  end

  def create
    false
  end

  def new
    create
  end

  def update
    false
  end

  def edit
    update
  end

  def destroy
    false
  end

  def scope
    Pundit.policy_scope! user, model.class
  end

  class Scope
    attr_reader :user, :scope

    def initialize user, scope
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
