require 'waffle/version'
require 'waffle/utils'
require 'waffle/base'
require 'waffle/configuration'
require 'waffle/producer'
require 'waffle/consumer'
require 'waffle/event'

module Waffle
  module Strategies

    autoload :RabbitMQ, 'waffle/strategies/rabbitmq'

  end
end
