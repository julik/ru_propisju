# -*- encoding: utf-8 -*-
# -*- ruby -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require 'rubygems'
require 'jeweler'
require './lib/ru_propisju'

Jeweler::Tasks.new do |gem|
  gem.version = RuPropisju::VERSION
  gem.name = "ru_propisju"
  gem.summary = "Cумма прописью"
  gem.email = "me@julik.nl"
  gem.homepage = "http://github.com/julik/ru_propisju"
  gem.authors = ["Julik Tarkhanov"]
  gem.license = 'MIT'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
desc "Run all tests"
Rake::TestTask.new("test") do |t|
  t.libs << "test"
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end

task :default => [ :test ]

# vim: syntax=ruby
