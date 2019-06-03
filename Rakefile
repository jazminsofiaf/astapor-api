# frozen_string_literal: true

require './app'
require 'sinatra/activerecord/rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'cucumber/rake/task'
require 'sinatra/activerecord'

RACK_ENV = ENV['RACK_ENV'] ||= 'test' unless defined?(RACK_ENV)

task :all do
  ['rubocop', 'rake spec'].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
  end
end

task :build_server do
  ['rake spec_report'].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    raise "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
  end
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = '--color --format d'
end

RSpec::Core::RakeTask.new(:spec_report) do |t|
  t.pattern = './spec/**/*_spec.rb'
  t.rspec_opts = %w[--format RspecJunitFormatter --out reports/spec/spec.xml]
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.options = ['--display-cop-names']
  task.requires << 'rubocop-rspec'
end

task default: %i[spec rubocop]
