require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

require 'bundler'
Bundler.require :default, :development

include Victor
