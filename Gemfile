source "https://rubygems.org"

gemspec

group :development do
  gem "guard-rubocop", require: false
  gem "guard-rspec", require: false
  gem "terminal-notifier-guard", require: false
end

group :development, :test do
  gem "rubocop"
  gem "jazz_hands",
      github: "nixme/jazz_hands", branch: "bring-your-own-debugger"
  gem "pry-byebug"
  gem "pry-coolline"
end

group :test do
  gem "rspec", "~> 3.0.0.beta2"
  gem "webmock"
  gem "vcr"
  gem "coveralls", require: false
end
