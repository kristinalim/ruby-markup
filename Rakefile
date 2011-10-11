# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "markup"
  gem.homepage = "http://github.com/kristinalim/ruby-markup"
  gem.license = "MIT"
  gem.summary = %Q{A centralized interface for translation of markup from one format to another}
  gem.description = %Q{This gem provides a simple, centralized interface for translation of markup from one format to another. It comes with a bunch of processors, and handles requirement of optional dependencies as configured needed.}
  gem.email = "thenonymous@gmail.com"
  gem.authors = ["Kristina Lim"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "markup #{version}"
  rdoc.main = 'README.rdoc'
  rdoc.rdoc_files.include('LICENSE.txt', 'README.txt', 'VERSION')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
