class Request < ApplicationRecord
  belongs_to :user, optional: true
  validates :kind, presence: true
  validates :reason, presence: true
  validates :date_leave_to, presence: true
  validates :date_leave_from, presence: true
  validates :compensation_time_from, presence: true
  validates :compensation_time_to, presence: true
  validate :check_time
  validate :check_compensation_time

  enum kind: ["il", "lo", "le"]
  enum approved: [:init, :approved, :reject]
  private
  def check_time
    unless date_leave_from.nil? && date_leave_to.nil?
      errors.add :requests, I18n.t("request.time_fail") if date_leave_from > date_leave_to
    end
  end

  def check_compensation_time
    unless compensation_time_from.nil? && compensation_time_to.nil?
      if compensation_time_from > compensation_time_to && compensation_time_from > date_leave_to
        errors.add :requests, I18n.t("request.time_fail")
      end
    end
  end
end
