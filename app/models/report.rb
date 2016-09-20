class Report < ApplicationRecord
  belongs_to :user
  belongs_to :languages
  belongs_to :progress
end
