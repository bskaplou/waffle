require 'date'
require 'bunny'

module Waffle
  module Transports
    class Rabbitmq

      CONNECTION_ATTEMPT_TIMEOUT = 30

      EXCHANGE = 'events'

      @@last_connection_attempt = Time.now

      def initialize
        @bunny = Bunny.new Waffle::Config.url
        connect
      end

      def encoder
        @encoder ||= eval("Waffle::Encoders::#{Waffle::Config.encoder.capitalize}")
      end

      def publish(flow = 'events', message = '')
        begin
          @exchange = @bunny.exchange EXCHANGE
          @exchange.publish message, :key => flow
        rescue
          if (Time.now - @@last_connection_attempt) > CONNECTION_ATTEMPT_TIMEOUT
            connect
          end
        end
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
          yield message[:delivery_details][:routing_key], encoder.decode(message[:payload])
        end
      end

      private

        def connect
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
