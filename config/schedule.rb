# frozen_string_literal: true
# this will run 1 pm UTC
every :day, at: '1:00 pm' do
  command 'cd /var/www/hubspot/current && RAILS_ENV=production bin/run'
end
