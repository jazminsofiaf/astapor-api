# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.1'

gem 'pg', '~> 0.18'
gem 'sequel'

gem 'json'
gem 'rake'
gem 'rb-readline'
gem 'sinatra'

group :development, :test do
  gem 'cucumber'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rspec_junit_formatter'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
  gem 'byebug'
  gem 'guard'
  gem 'guard-rspec'
  gem 'ruby-debug-ide'
end
