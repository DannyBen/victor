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

  s.required_ruby_version = '>= 3.0.0'

  s.metadata = {
    'bug_tracker_uri'       => 'https://github.com/DannyBen/victor/issues',
    'changelog_uri'         => 'https://github.com/DannyBen/victor/blob/master/CHANGELOG.md',
    'homepage_uri'          => 'https://victor.dannyb.co/',
    'source_code_uri'       => 'https://github.com/DannyBen/victor',
    'rubygems_mfa_required' => 'true',
  }
end
