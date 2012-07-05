require 'rake'
$LOAD_PATH.unshift File.expand_path("../..", __FILE__)
Dir[File.join('lib', 'tasks', '**', '*.rake')].each{|file| load file}

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => [:spec]
