RACK_ENV = 'test'.freeze unless defined?(RACK_ENV)

require File.expand_path(File.dirname(__FILE__) + '/../config/boot')
Dir[File.expand_path(File.dirname(__FILE__) + '/../app/helpers/**/*.rb')].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include Capybara
end

def app
  AstaporGuarani::App.tap { |app| }
  AstaporGuarani::App.set :protect_from_csrf, false
end
