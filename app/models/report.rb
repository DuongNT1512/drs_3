class Report < ApplicationRecord
  belongs_to :user
  belongs_to :language
  belongs_to :progress
  belongs_to :division

  delegate :name, to: :division, prefix: true, allow_nil: true
  delegate :name, to: :language, prefix: true, allow_nil: true
  delegate :name, to: :progress, prefix: true, allow_nil: true

  enum working_day: ["All_day", "Morning", "Afternoon"]

  ["position", "language", "progress"].each do |attr|
    define_method "user_#{attr}" do ||
      send("#{attr}_name")
    end
  end
end
