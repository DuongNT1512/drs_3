class UsersMailer < ApplicationMailer

  def mail_dayly user_id
    @users = users
    mail to: admin.email, subject: I18n.t("mailer.requests.subject")
  end
  def reports_of_user_report manager, reports
    @reports = reports
    mail to: manager.user.email, subject: I18n.t("mailer.reports.subject")
  end

  def reports_of_user_request admin, users
    @users = users
    mail to: admin.email, subject: I18n.t("mailer.requests.subject")
  end

  def reports_of_least_report admin, users
    @users = users
    mail to: admin.email, subject: I18n.t("mailer.least_reports.subject")
  end
end
