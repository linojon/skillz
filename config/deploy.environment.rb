ENV['RAILS_ENV'] ||= 'production'

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Skillz::Application.initialize!

# # use gmail for outgoing mail
# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
#   :address => 'smtp.gmail.com',
#   :port => 587,
#   :domain => APP_CONFIG[:host],
#   :user_name => 'mygmailname',
#   :password => 'secret',
#   :authentication => 'plain',
#   :enable_starttls_auto => true
# }
