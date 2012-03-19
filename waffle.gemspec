$:.push File.expand_path("../lib", __FILE__)

require "waffle/version"

Gem::Specification.new do |s|
  s.name    = 'waffle'
  s.version = Waffle::VERSION

  s.authors = ['Alexander Lomakin']
  s.email   = 'alexander.lomakin@gmail.com'

  s.homepage = ''

  s.summary     = 'Abstract queue sender and receiver'
  s.description = 'Abstract queue sender and receiver'

  s.files = `git ls-files`.split("\n")

  s.add_runtime_dependency 'bunny'
  s.add_runtime_dependency 'yajl-ruby'
end
