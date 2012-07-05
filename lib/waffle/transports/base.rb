module Waffle
  module Transports
    class Base
      def initialize
        connect!
      end

      def ready_to_connect?
        (Time.now - @last_connection_attempt) > Waffle.config.connection_attempt_timeout
      end

      def reconnect
        connect!
      end

      protected
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
