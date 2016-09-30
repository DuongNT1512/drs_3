class Position < ApplicationRecord
  belongs_to :division, optional: true
  has_many :users, dependent: :destroy
end
