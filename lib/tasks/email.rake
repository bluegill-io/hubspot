require 'mail'

namespace :email do
  desc "Send an email with our newly acquired data"
  task :send do
    # options = { 
    #   :address              => "smtp.gmail.com",
    #   :port                 => 587,
    #   :user_name            => '65monroe@gmail.com',
    #   :password             => '<gmail password>',
    #   :authentication       => 'plain',
    #   :enable_starttls_auto => true  
    # }

    Mail.defaults do
      delivery_method :smtp, address: "localhost", port: 1025
    end

    Mail.deliver do
      from     'mikel@test.lindsaar.net'
      to       'you@test.lindsaar.net'
      subject  'This is a test email'
      body     'Here is our data'
      add_file 'boom.xls'
    end

    puts "[Rake Task][Email:Send] Completed"
  end
end