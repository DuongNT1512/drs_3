class Language < ApplicationRecord
  has_many :report, dependent: :destroy
end
