$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

# dependencies
require "rubygems"
require "rspec"
require "gratitude"
require "vcr"
require "webmock"

# VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.stub_with :webmock
end