# frozen_string_literal: true

require 'sequel'
require 'padrino'

Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
# frozen_string_literal: true
DB =
  case Padrino.env
  when :development
    Sequel.connect('postgres://astapor:astapor@localhost/astapor_development',
                   loggers: [logger])
  when :test
    test_db_host = ENV['DB_HOST'] || 'localhost'
    Sequel.connect("postgres://astapor:astapor@#{test_db_host}/astapor_test",
                   loggers: [logger])
  when :staging
    Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
  when :production
    Sequel.connect(ENV['DATABASE_URL'], loggers: [logger])
  end

DB.loggers << Logger.new($stdout)
