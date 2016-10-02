class UsersMailer < ApplicationMailer

  def mail_dayly user_id
    @user = User.find_by id: user_id
    if @user.present? && @user.division.present?
      mail to: @user.email, subject: "Report Dayly"
    end
  end
end
