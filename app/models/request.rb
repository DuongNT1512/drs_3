class Request < ApplicationRecord
  belongs_to :user, optional: true
  validates :request_kind, presence: true
  validates :reason, presence: true
  validates :date_leave_to, presence: true
  validates :date_leave_from, presence: true
  validates :compensation_time_from, presence: true
  validates :compensation_time_to, presence: true

  validate :check_time
  validate :check_compensation_time

  delegate :username, to: :user, prefix: true, allow_nil: true
  enum request_kind: ["in_late", "leave_out", "leave_early"]
  enum approved: [:init, :approved, :reject]

  scope :request_init, -> {where approved: :init}
  scope :all_division, -> manager_division_id {where "user_id IN
    (SELECT id FROM users WHERE division_id = ?)", manager_division_id}

  private
  def check_time
    unless date_leave_from.nil? && date_leave_to.nil?
      unless date_leave_from < date_leave_to
        errors.add :requests, I18n.t("request.time_fails1")
        return false
      end
    end
    true
  end

  def check_compensation_time
    unless compensation_time_from.nil? && compensation_time_to.nil?
      unless compensation_time_from < compensation_time_to || compensation_time_from < date_leave_to
        errors.add :requests, I18n.t("request.time_fails2")
        return false
      end
    end
    true
  end
end
