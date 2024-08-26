require 'simplecov'
unless ENV['NOCOV']
  SimpleCov.start do
    enable_coverage :branch if ENV['BRANCH_COV']
    coverage_dir 'spec/coverage'
    # track_files 'lib/**/*.rb'
  end
end

require 'bundler'
Bundler.require :default, :development

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/status.txt'
end
