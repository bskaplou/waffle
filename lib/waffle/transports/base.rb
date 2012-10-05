module Waffle
  module Transports
    class Base
      attr_reader :config
      def initialize config
        @config = config
        connect!
      end

      def publish flow = 'events', message = ''
        publish_impl(flow, message)
      rescue *connection_exceptions => e
        reconnect && retry if ready_to_connect?
      end

      def subscribe flow = '', &block
        subscribe_impl(flow, &block)
      rescue *connection_exceptions => e
        until reconnect do
          sleep(config.connection_attempt_timeout)
        end
        retry
      end

      protected
      def ready_to_connect?
        (Time.now - @last_connection_attempt) > config.connection_attempt_timeout
      end

      def reconnect
        connect!
      end

      def encoder
        @encoder ||= "Waffle::Encoders::#{config.encoder.camelize}".constantize
      end

      def connect!
        @last_connection_attempt = Time.now
        do_connect
      rescue
        false
      end

      def do_connect
      end
    end
  end
end
