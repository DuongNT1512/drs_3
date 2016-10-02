class DaylyWorker
  include Sidekiq::Worker

  MAIL_DAYLY = 1

  def perform action, user_id
    case action
    when MAIL_DAYLY
      send_email_dayly user_id
    end
  end

  private
  def send_email_dayly user_id
    UsersMailer.mail_dayly(user_id).deliver_now
  end
end
