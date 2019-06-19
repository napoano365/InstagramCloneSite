source 'https://rubygems.org'

gem 'rails', '~> 5.2.3'
gem 'bcrypt', '~> 3.1.7'
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass', '3.3.7'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
gem 'omniauth'
gem 'omniauth-facebook'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'rspec-rails', '~>3.6.0'
  gem 'sqlite3', '1.3.13'
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara'
  gem 'rspec-rails', '~> 3.6.0'
end

group :production do
 gem 'fog', '1.42'
 gem 'pg', '0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
