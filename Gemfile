source "http://rubygems.org"

gem 'rake'

group :development, :test do
  gem 'pry'
  gem 'yajl-ruby', require: 'yajl'
  gem 'bunny'
  gem "hiredis", "~> 0.3.1", :platforms => :ruby
  gem "redis", "~> 2.2.0", require: RUBY_PLATFORM =~ /mingw|mswin/ ? 'redis' : ["redis/connection/hiredis", "redis"]
end

group :test do
  gem 'rspec'
end
