require 'mail'

namespace :email do
  desc "Send an email with our newly acquired data"
  task :send do
    options = { 
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :user_name            => '',
      :password             => '',
      :authentication       => 'plain',
      :enable_starttls_auto => true  
    }

    Mail.defaults do
      delivery_method :smtp, options
    end

    Mail.deliver do
      from     ''
      to       ''
      subject  'This is a test email'
      body     'Here is our data'
      add_file 'report.xlsm'
    end

    puts "[Rake Task][Email:Send] Completed"
  end
end