set :output, "/var/www/hubspot/logs/cron_log.log"

every :day, :at => '3:40 pm' do
  command "RAILS_ENV=production bin/run"
end
