require 'waffle/version'
require 'waffle/base'
require 'waffle/producer'
require 'waffle/consumer'

module Waffle
  module Strategies

    autoload :RabbitMQ, 'waffle/strategies/rabbitmq'

  end
end
