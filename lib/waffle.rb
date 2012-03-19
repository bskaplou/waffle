require 'waffle/version'
require 'waffle/utils'
require 'waffle/base'
require 'waffle/configuration'
require 'waffle/event'

module Waffle
  module Strategies

    autoload :Rabbitmq, 'waffle/strategies/rabbitmq'

  end
end
