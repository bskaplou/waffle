require 'bunny'

module Waffle
  module Strategies
    class Rabbitmq

      def initialize(configuration = nil)
        raise ArgumentError unless configuration && configuration.is_a?(Waffle::Configuration)
        @bunny = Bunny.new configuration.url
        @bunny.start
      end

      def publish(flow = 'events', message = '')
        @exchange = @bunny.exchange flow
        @exchange.publish message
      end

      def subscribe(flow = 'events')
        @exchange = @bunny.exchange flow
        @queue    = @bunny.queue '', :durable => true, :auto_delete => true
        @queue.bind @exchange

        @queue.subscribe do |message|
          yield Waffle::Utils.decode(message[:payload])
        end
      end

    end
  end
end
