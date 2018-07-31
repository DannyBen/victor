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
  s.required_ruby_version = ">= 2.0.0"

  s.add_development_dependency 'runfile', '~> 0.10'
  s.add_development_dependency 'runfile-tasks', '~> 0.4'
  s.add_development_dependency 'rspec', '~> 3.6'
  s.add_development_dependency 'simplecov', '~> 0.16'
  s.add_development_dependency 'filewatcher', '~> 1.0'
end
