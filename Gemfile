source "https://rubygems.org"

gemspec

group :development do
  gem "guard-rubocop", require: false
  gem "guard-rspec", require: false
  gem "jazz_hands",
      github: "nixme/jazz_hands", branch: "bring-your-own-debugger"
  gem "pry-byebug"
  gem "pry-coolline"
  gem "terminal-notifier-guard", require: false
end

group :development, :test do
  gem "rubocop"
end

group :test do
  gem "rspec", "~> 3.1.0"
  gem "webmock"
  gem "vcr"
  gem "coveralls", require: false
end
