# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gratitude/version'

Gem::Specification.new do |spec|
  spec.name          = "gratitude"
  spec.version       = Gratitude::VERSION
  spec.authors       = ["John Kelly Ferguson"]
  spec.email         = ["hello@johnkellyferguson.com"]
  spec.description   = %q{A simple Ruby wrapper for the Gittip API.}
  spec.summary       = %q{A simple Ruby wrapper for the Gittip API.}
  spec.homepage      = "https://github.com/JohnKellyFerguson/gratitude"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.8.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
