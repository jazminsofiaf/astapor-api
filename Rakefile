require 'bundler/setup'
require 'padrino-core/cli/rake'
require 'English'

RACK_ENV = ENV['RACK_ENV'] ||= ENV['RACK_ENV'] ||= 'test' unless defined?(RACK_ENV)

task :version do
  require './lib/version.rb'
  puts Version.current
  exit 0
end

PadrinoTasks.use(:database)
PadrinoTasks.use(:sequel)
PadrinoTasks.init

task :all do
  puts '===========  Running migrations   ==========================='
  Rake::Task['db:migrate'].invoke
  Rake::Task['db:seed'].invoke
  ['rubocop', 'rake spec'].each do |cmd|
    puts "===========  Starting to run #{cmd}  ==========================="
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    puts "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
  end
end

task :rollback do
  Rake::Task['db:redo'].invoke
end

task :build_server do
  ['rake spec_report'].each do |cmd|
    puts "Starting to run #{cmd}..."
    system("export DISPLAY=:99.0 && bundle exec #{cmd}")
    puts "#{cmd} failed!" unless $CHILD_STATUS.exitstatus.zero?
  end
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = './spec/**/*_spec.rb'
  end
rescue LoadError
  puts 'Error al cargar rake-task'
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec_report) do |t|
    t.pattern = './spec/**/*_spec.rb'
    t.rspec_opts = %w[--format RspecJunitFormatter --out reports/spec/spec.xml]
  end
rescue LoadError
  puts 'Error al cargar rake-task'
end

begin
  require 'rubocop/rake_task'
  desc 'Run RuboCop on the lib directory'
  RuboCop::RakeTask.new(:rubocop) do |task|
    # run analysis on rspec tests
    task.requires << 'rubocop-rspec'
    # don't abort rake on failure
    task.fail_on_error = false
  end
rescue LoadError
  puts 'Error al cargar rake-task'
end

task default: [:all]
