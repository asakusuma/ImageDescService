source 'http://rubygems.org'

gem 'rails', '3.0.4'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'thin' # avoids massive memory consumption (as with webrick) on dev machine
gem 'mysql2'
gem 'uuidtools'
gem 'test-unit'
gem 'zipruby'
gem 'aws-sdk'
gem 'activeadmin'
gem 'cancan'
gem 'jquery-rails', '>= 1.0.12'
gem "haml"
gem "paperclip", "~> 3.0"
gem "paperclip-aws"
gem "tire"

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

gem 'ruby-xslt'
gem 'image_size'
gem 'parallel'
gem 'delayed_job'
gem 'devise'
gem 'newrelic_rpm'
gem 'kaminari'
gem "airbrake"
gem 'rack-ssl', :require => 'rack/ssl'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
#   gem 'webrat'
	gem 'rspec-rails'
	gem 'cucumber-rails', :require => false
	gem 'capybara' # seems to be required by cucumber-rails
	gem 'database_cleaner' # seems to be required by cucumber-rails
  gem 'sqlite3'
  gem 'foreman'
  gem 'oink'
  gem 'factory_girl_rails'
end
