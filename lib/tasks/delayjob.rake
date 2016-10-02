namespace :delayjob do
  desc "TODO"
  task maildayly: :environment do
    User.manager.each do |user|
      DaylyWorker.perform_async DaylyWorker::MAIL_DAYLY, user.id
    end
  end
end
