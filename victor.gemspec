lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'victor/version'

Gem::Specification.new do |s|
  s.name        = 'victor'
  s.version     = Victor::VERSION
  s.summary     = 'SVG Builder'
  s.description = 'Build SVG images with ease'
  s.authors     = ['Danny Ben Shitrit']
  s.email       = 'db@dannyben.com'
  s.files       = Dir['README.md', 'lib/**/*.*']
  s.homepage    = 'https://github.com/DannyBen/victor'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.6.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
