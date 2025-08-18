source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
#gem "sqlite3", ">= 2.1"
gem 'pg'
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
#gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
##gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem 'database_cleaner-active_record'
end

gem "dotenv-rails", "~> 3.1", groups: [ :development, :test ]

gem "devise", "~> 4.9"

gem "wicked"
gem "date_common"
gem "text_common"
gem "time_common"
gem "url_common"
gem 'ostruct'
gem 'awesome_print'

gem 'acts_as_votable'
gem 'image_processing', '~> 1.12'
gem 'vobject'

gem 'mailgun-ruby'

# group :production do
#   gem 'rmagick'
#   gem 'rqrcode'
# end
gem "honeybadger", "~> 5.28"

#gem 'ruby-vips'
#gem 'pagy', require: ['pagy/extras/bootstrap']
gem 'kaminari'
gem 'whenever', require: false
gem 'ice_cube'

# gem 'rails-observers'
# gem 'merit'

###gem 'activerecord-postgis-adapter'
gem 'rgeo' # handles geometry objects
gem 'rgeo-activerecord'
gem 'rgeo-geojson' 

gem "meilisearch-rails"

gem 'chronic'

gem 'geocoder'
gem "feedjira", "~> 3.2"

#
# jobs
#
gem "sidekiq", "~> 8.0"
gem "sidekiq-cron", "~> 2.3"

gem "rails-controller-testing", "~> 1.0"