$:.push File.expand_path("../lib", __FILE__)

require "waffle/version"

Gem::Specification.new do |s|
  s.name    = 'waffle'
  s.version = Waffle::VERSION

  s.homepage = 'http://github.com/undr/waffle'
  s.authors  = ['Alexander Lomakin', 'Andrey Lepeshkin']
  s.email    = 'alexander.lomakin@gmail.com'

  s.summary     = 'Abstract flow publisher and subscriber'
  s.description = 'Client part of Patty statistics server'

  s.files = `git ls-files`.split("\n")
  s.add_dependency("rake")
end
