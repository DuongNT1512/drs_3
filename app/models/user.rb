class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  belongs_to :division, optional: true
  belongs_to :position, optional: true
  belongs_to :language, optional: true

  has_many :reports, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  enum role: [:admin, :manager, :employee]
  delegate :name, to: :division, prefix: true, allow_nil: true
  delegate :name, to: :position, prefix: true, allow_nil: true
  delegate :name, to: :language, prefix: true, allow_nil: true

  ["position", "language", "division"].each do |attr|
    define_method "user_#{attr}" do ||
      send("#{attr}_name")
    end
  end
end
