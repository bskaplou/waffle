require 'date'
require 'bunny'

module Waffle
  module Transports
    class Rabbitmq < Base
      EXCHANGE = 'events'

      protected
      def publish_impl(flow = 'events', message = '')
        exchange.publish(encoder.encode(message), :key => flow)
      end

      def subscribe_impl(flow = 'events', &block)
        if flow.is_a?(Array)
          flow.each{|f| queue.bind(exchange, :key => f)}
        else
          queue.bind(exchange, :key => flow)
        end

        queue.subscribe do |message|
          block.call(message[:delivery_details][:routing_key], encoder.decode(message[:payload]))
        end
      end

      def connection_exceptions
        [Bunny::ServerDownError, Bunny::ConnectionError, Errno::ECONNRESET]
      end

      def exchange
        @exchange ||= @bunny.exchange(config.options['exchange'] || EXCHANGE)
      end

      def queue
        @queue ||= @bunny.queue(config.options['queue'] || '', :durable => true, :auto_delete => true)
      end

      def do_connect
        @exchange = nil
        @queue = nil
        @bunny = Bunny.new(config.url)
        @bunny.start
      end
    end
  end
end
