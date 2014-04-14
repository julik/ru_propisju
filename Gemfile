source 'https://rubygems.org'

group :development do
  gem "bundler"
  
  if RUBY_VERSION > "1.8" # Jeweler pulls Nokogiri which does not want to build on Travis in 1.8
    gem "jeweler", '~> 1.8.8'
  else
    gem "jeweler", '~> 1.8.4'
  end
  
  gem "rake"
  gem "test-unit"
end