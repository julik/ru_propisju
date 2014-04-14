source 'https://rubygems.org'

group :development do
  if RUBY_VERSION < "1.9" # Jeweler pulls Nokogiri which does not want to build on Travis in 1.8
    gem "jeweler", '1.8.4'
  else
    gem "jeweler", '~> 1.8'
  end
  
  gem "rake"
  gem "test-unit"
end