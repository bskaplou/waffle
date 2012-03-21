require 'bunny'

module Waffle
  module Transports
    class Rabbitmq

      def initialize(configuration = nil)
        raise ArgumentError unless configuration && configuration.is_a?(Waffle::Configuration)

        @configuration = configuration
        @bunny = Bunny.new configuration.url
        @bunny.start
      end

      def encoder
        @encoder ||= eval("Waffle::Encoders::#{@configuration.encoder}")
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
          yield encoder.decode(message[:payload])
        end
      end

    end
  end
end
