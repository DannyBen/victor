require 'simplecov'
SimpleCov.start

require 'rubygems'
require 'bundler'
Bundler.require :default, :development

def fixture(file)
  File.read "spec/fixtures/#{file}"
end