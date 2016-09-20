class Division < ApplicationRecord
  has_many :position, dependent: :destroy
  has_many :user, dependent: :destroy
end
