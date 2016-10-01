class Division < ApplicationRecord
  has_many :positions, dependent: :destroy
  has_many :users, dependent: :destroy
end
