source 'http://rubygems.org'

#gem 'rails', '3.0.3'
gem 'rails', '3.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end

gem 'haml'
gem "haml-rails"      #generators
gem 'compass', ">= 0.10.5"
gem 'fancy-buttons'
gem 'simple_form'
gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'
gem 'meta_where'
gem 'rdiscount' #aka markdown

group :development, :test, :cucumber do
  gem 'ruby-debug19'
  gem 'nifty-generators'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'cucumber'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  
  gem "rspec-rails", ">= 2.2.0"
  gem 'shoulda'
  gem 'machinist', '1.0.6'
  # gem 'sham' #not needed here, machinist fetches it
  gem 'faker'
  #gem 'pickle' # cuke steps to generate models
  gem 'email_spec'
end
