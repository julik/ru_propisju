# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = "ru_propisju"
  s.version = "2.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Julik Tarkhanov"]
  s.date = "2016-05-20"
  s.email = "me@julik.nl"
  s.extra_rdoc_files = [
    "README.rdoc"
  ]

  # Prevent pushing this gem to RubyGems.org.
  # To allow pushes either set the 'allowed_push_host'
  # To allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  s.files = `git ls-files -z`.split("\x0")
  s.homepage = "http://github.com/julik/ru_propisju"
  s.licenses = ["MIT"]
  s.rubygems_version = '2.2.2'
  s.summary = 'Cумма прописью'

  s.specification_version = 4

  s.add_development_dependency 'bundler', '~> 1'
  s.add_development_dependency('rake', ["~> 10"])
  s.add_development_dependency('test-unit', ["= 3.1.3"])
end
