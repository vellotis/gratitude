# encoding: utf-8

require "rubygems"
require "bundler/gem_tasks"

Bundler.setup :default, :development

require "rspec/core"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList["spec/**/*_spec.rb"]
end

task default: :spec

task :console do
  require "irb"
  require "irb/completion"
  require "gratitude"
  ARGV.clear
  IRB.start
end

task :pry do
  require "pry"
  require "gratitude"
  ARGV.clear
  Pry.start
end
