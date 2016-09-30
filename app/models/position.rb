class Position < ApplicationRecord
  belongs_to :division, optional: true
  has_many :user, dependent: :destroy
end
