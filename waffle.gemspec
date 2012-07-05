$:.push File.expand_path("../lib", __FILE__)

require "waffle/version"

Gem::Specification.new do |s|
  s.name = 'waffle'
  s.version = Waffle::VERSION
  s.rubyforge_project = "waffle"

  s.homepage = 'http://github.com/undr/waffle'
  s.authors = ['Alexander Lomakin', 'Andrey Lepeshkin']
  s.email = ['alexander.lomakin@gmail.com', 'lilipoper@gmail.com']

  s.summary = 'Abstract flow publisher and subscriber'
  s.description = 'Abstract flow publisher and subscriber'

  s.files = `git ls-files`.split("\n")
  s.add_dependency("rake")
end
