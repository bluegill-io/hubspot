set :output, "/var/www/hubspot/logs/cron_log.log"

every :day, :at => '8:00 am' do
  command "../bin/run"
end
