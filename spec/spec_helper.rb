$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# Coveralls
require 'coveralls'
Coveralls.wear!

# dependencies
require "rubygems"
require "rspec"
require "gratitude"
require "vcr"
require "webmock"

# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { record: :new_episodes, serialize_with: :json }
end