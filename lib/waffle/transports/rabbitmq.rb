require 'date'
require 'bunny'

module Waffle
  module Transports
    class Rabbitmq < Base
      EXCHANGE = 'events'

      def publish(flow = 'events', message = '')
        exchange.publish(Waffle.encoder.encode(message), :key => flow)
      end

      def subscribe(flow = 'events')
        if flow.is_a?(Array)
          flow.each{|f| queue.bind(exchange, :key => f)}
        else
          queue.bind(exchange, :key => flow)
        end

        queue.subscribe do |message|
          yield(message[:delivery_details][:routing_key], Waffle.encoder.decode(message[:payload]))
        end
      end

      def connection_exceptions
        [Bunny::ServerDownError, Bunny::ConnectionError, Errno::ECONNRESET]
      end

      private
      def exchange
        @exchange ||= @bunny.exchange(EXCHANGE)
      end

      def queue
        @queue ||= @bunny.queue('', :durable => true, :auto_delete => true)
      end

      def do_connect
        @exchange = nil
        @queue = nil
        @bunny = Bunny.new(Waffle.config.url)
        @bunny.start
      end
    end
  end
end
