class Report < ApplicationRecord
  belongs_to :user
  belongs_to :language
  belongs_to :progress
  belongs_to :division

  validates :achievement, presence: true

  delegate :name, to: :division, prefix: true, allow_nil: true
  delegate :name, to: :language, prefix: true, allow_nil: true
  delegate :name, to: :progress, prefix: true, allow_nil: true

  enum working_day: ["all_day", "morning", "afternoon"]

  ["position", "language", "progress"].each do |attr|
    define_method "user_#{attr}" do ||
      send("#{attr}_name")
    end
  end

  scope :all_division, -> manager_division_id {where "user_id IN
    (SELECT id FROM users WHERE division_id = ?)", manager_division_id}

end
