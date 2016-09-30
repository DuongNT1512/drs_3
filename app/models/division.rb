class Division < ApplicationRecord
  has_many :position, dependent: :destroy
  has_many :users, dependent: :destroy
end
