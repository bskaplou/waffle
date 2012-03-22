$:.push File.expand_path("../lib", __FILE__)

require "waffle/version"

Gem::Specification.new do |s|
  s.name    = 'waffle'
  s.version = Waffle::VERSION

  s.homepage = 'http://github.com/peanut/waffle'
  s.authors  = ['Alexander Lomakin']
  s.email    = 'alexander.lomakin@gmail.com'

  s.summary     = 'Abstract flow publisher and subscriber'
  s.description = 'Client part of Patty statistics server'

  s.files = `git ls-files`.split("\n")

  s.add_runtime_dependency 'bunny'
  s.add_runtime_dependency 'yajl-ruby'
end
