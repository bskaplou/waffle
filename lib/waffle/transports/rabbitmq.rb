require 'bunny'

module Waffle
  module Transports
    class Rabbitmq

      EXCHANGE = 'events'

      def initialize
        @bunny = Bunny.new Waffle::Config.url
        @bunny.start
      end

      def encoder
        @encoder ||= eval("Waffle::Encoders::#{Waffle::Config.encoder.capitalize}")
      end

      def publish(flow = 'events', message = '')
        @exchange = @bunny.exchange EXCHANGE
        @exchange.publish message, :key => flow
      end

      def subscribe(flow = 'events')
        @exchange = @bunny.exchange EXCHANGE
        @queue    = @bunny.queue '', :durable => true, :auto_delete => true
        if flow.is_a? Array
          flow.each{ |f| @queue.bind @exchange, :key => f }
        else
          @queue.bind @exchange, :key => flow
        end

        @queue.subscribe do |message|
          yield message[:routing_key], encoder.decode(message[:payload])
        end
      end

    end
  end
end
