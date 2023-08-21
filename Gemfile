# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'rails', '~> 7.0.7'

gem 'bcrypt' # Use Active Model has_secure_password
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'good_job' # Multithreaded, Postgres-based, ActiveJob backend for Ruby on Rails
gem 'image_processing' # Use Active Storage variants
gem 'pg' # Use postgresql as the database for Active Record
gem 'puma' # Use the Puma web server [https://github.com/puma/puma]
gem 'vite_rails' # Use ViteRails to compile assets

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'annotate', github: 'robbevp/annotate_models', branch: 'enhc/support-virtual-columns'
  gem 'erb_lint'
  gem 'pgreset' # Easily reset the database while connections are active
  gem 'rack-mini-profiler' # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'web-console' # Use console on exceptions pages [https://github.com/rails/web-console]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'simplecov-cobertura'
  gem 'webdrivers'
end
