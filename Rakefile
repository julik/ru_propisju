# -*- encoding: utf-8 -*-
$KCODE = 'u' if RUBY_VERSION < '1.9.0'

require 'rubygems'
require './lib/ru_propisju'
require 'bundler/gem_tasks'
require 'rake/testtask'

desc "Run all tests"
Rake::TestTask.new("test") do |t|
  t.libs << "test"
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end

task :default => [ :test ]

