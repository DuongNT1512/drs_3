class Progress < ApplicationRecord
  has_many :report, dependent: :destroy
end
