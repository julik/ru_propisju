# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: ru_propisju 2.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "ru_propisju"
  s.version = "2.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Julik Tarkhanov"]
  s.date = "2014-04-15"
  s.email = "me@julik.nl"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "History.txt",
    "README.rdoc",
    "Rakefile",
    "lib/ru_propisju.rb",
    "ru_propisju.gemspec",
    "test/test_ru_propisju.rb"
  ]
  s.homepage = "http://github.com/julik/ru_propisju"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "C\u{443}\u{43c}\u{43c}\u{430} \u{43f}\u{440}\u{43e}\u{43f}\u{438}\u{441}\u{44c}\u{44e}"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<jeweler>, ["~> 2"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
    else
      s.add_dependency(%q<jeweler>, ["~> 2"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
    end
  else
    s.add_dependency(%q<jeweler>, ["~> 2"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
  end
end

