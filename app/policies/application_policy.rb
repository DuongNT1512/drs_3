class ApplicationPolicy
  attr_reader :current_user, :model

  def initialize current_user, model
    raise Pundit::NotAuthorizedError, I18n.t("notification.login") unless current_user
    @current_user = current_user
    @model = model
  end

  def index

  end

  def show
    scope.where(id: model.id).exists?
  end

  def create
    true
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
    true
  end

  def scope
    Pundit.policy_scope! current_user, model.class
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize current_user, scope
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
