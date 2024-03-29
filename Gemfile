source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', :group => [:development, :test]
group :production do
  gem 'thin'
  gem 'pg'
end

#seo gem
gem 'meta-tags', :require => 'meta_tags'

#google analytics
gem 'google-analytics-rails'

#upload images
gem 'carrierwave'

#rich text editor for blogs
gem "ckeditor"

#importing csv files for festivals
gem 'roo'

#user messages and such
gem "has_mailbox"

#filter and search gem
gem "meta_search"


#comments and voting
gem 'acts_as_commentable', '3.0.1'
gem 'acts_as_votable', '~> 0.5.0'

#pagination
gem 'will_paginate', '~> 3.0'

#easy form format
gem 'simple_form'
gem 'country_select'

#track info
gem 'newrelic_rpm'


#google maps for rails
gem 'gmaps4rails'

#handles assets for heroku
group :assets do
  gem 'asset_sync'
end

#storage and picture uploads
gem 'aws-s3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'
# gem 'jcountdown-rails', :git => 'http://github.com/rezwyi/jcountdown-rails.git'

gem 'event-calendar', :require => 'event_calendar'

#private configuration and easy to push to heroku
gem 'figaro'

#authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook', '1.4.0'
gem 'omniauth-twitter'


#testing
gem "rspec-rails", :group => [:test, :development]
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem 'growl_notify' 
end


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
