class Language < ApplicationRecord
  has_many :reports, dependent: :destroy
  has_many :users, dependent: :destroy
end
