require 'bunny'

module Waffle
  module Strategies
    class Rabbitmq

      def initialize(configuration = nil)
        @bunny = Bunny.new configuration.url
        @bunny.start
      end

      def publish(flow = 'events', message = '')
        @exchange = @bunny.exchange exchange
        @exchange.publish message
      end

      def subscribe(flow = 'events')
        @exchange = @bunny.exchange exchange
        @queue    = @bunny.queue '', :durable => true, :auto_delete => true
        @queue.bind @exchange

        @queue.subscribe do |message|
          yield message[:payload]
        end
      end

    end
  end
end
