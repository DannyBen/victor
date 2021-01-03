require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

include Victor
