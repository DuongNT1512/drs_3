class Request < ApplicationRecord
  belongs_to :user, optional: true
  validates :request_kind, presence: true
  validates :reason, presence: true
  validates :date_leave_to, presence: true
  validates :date_leave_from, presence: true
  validates :compensation_time_from, presence: true
  validates :compensation_time_to, presence: true


  enum request_kind: ["in_late", "leave_out", "leave_early"]
  enum approved: [:init, :approved, :reject]

  private
  def check_time
    errors.add :requests, I18n.t("request.time_fail") if date_leave_from > date_leave_to
  end

  def check_compensation_time
    if compensation_time_from && compensation_time_to
      if compensation_time_from > compensation_time_to &&
        compensation_time_from > date_leave_to
        errors.add :requests, I18n.t("request.time_fail")
      end
    end
  end
end
