require 'date'
require 'bunny'

module Waffle
  module Transports
    class Rabbitmq

      EXCHANGE = 'events'

      @@last_connection_attempt = Time.now

      def initialize
        @bunny = Bunny.new(Waffle.config.url)
        connect!
      end

      def publish(flow = 'events', message = '')
        begin
          exchange.publish(message, :key => flow)
        rescue
          if (Time.now - @@last_connection_attempt) > Waffle.config.connection_attempt_timeout
            connect!
          end
        end
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

      private
      def exchange
        @exchange ||= @bunny.exchange(EXCHANGE)
      end

      def queue
        @queue ||= @bunny.queue('', :durable => true, :auto_delete => true)
      end

      def connect!
        begin
          @@last_connection_attempt = Time.now
          @bunny.start
        rescue
          nil
        end
      end
    end
  end
end
