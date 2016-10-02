set :environment, "development"
env :PATH, ENV["PATH"]

every :day, at: "8:00 pm" do
  rake "delayjob:maildayly"
end
