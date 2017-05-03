# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# href: http://eewang.github.io/blog/2013/03/12/how-to-schedule-tasks-using-whenever/
set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
set :chronic_options, hours24: true

every 1.days, at: '0:00' do
  rake "events:close_expired_events"
end
