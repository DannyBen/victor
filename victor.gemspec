lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'date'
require 'victor/version'

Gem::Specification.new do |s|
  s.name        = 'victor'
  s.version     = Victor::VERSION
  s.date        = Date.today.to_s
  s.summary     = "SVG Builder"
  s.description = "Build SVG images with ease"
  s.authors     = ["Danny Ben Shitrit"]
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/DannyBen/victor'
  s.license     = 'MIT'
  s.bindir = 'bin'
  s.required_ruby_version = ">= 2.3.0"

  s.add_runtime_dependency "nokogiri", ">=1.10.9"
  s.add_runtime_dependency "mister_bin", ">=0.7.1"
end
