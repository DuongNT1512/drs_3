class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:google_oauth2, :facebook]
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

  def check_manager?
    self.position_name == "Manager"
  end

  def check_employee?
    self.position_name == "Employee"
  end

  scope :all_manager, -> {where("position_id IN (select id from positions where
    positions.name = ?)", "Manager")}

  class << self
    def from_omniauth auth
      find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email.present?
        user.password = Settings.default_password
        user.fullname = auth.info.name
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.#{session["provider"]}_data"] &&
          session["devise.#{session["provider"]}_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end

   def send_mail_to_admins
    admins = User.load_admins
    users = User.includes :requests, :reports
    least_request_users = users.select{|user|
      user.requests.size > Settings.least_requests}
    least_reports_users = users.select{|user|
      user.reports.size < Settings.least_reports}
    admins.each do |admin|
      UserMailer.reports_of_user_request(admin, users).deliver_now
      UserMailer.reports_of_least_report(admin, users).deliver_now
      end
    end
  end
end
