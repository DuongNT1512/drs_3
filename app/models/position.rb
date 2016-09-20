class Position < ApplicationRecord
  belongs_to :division
  has_many :user, dependent: :destroy
end
