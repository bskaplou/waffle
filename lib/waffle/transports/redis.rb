module Waffle
  module Transports
    class Redis
      @@last_connection_attempt = Time.now

      attr_reader :db

      def initialize
        connect!
      end

      def publish(flow = 'events', message = '')
        begin
          db.publish(flow, message)
        rescue
          if (Time.now - @@last_connection_attempt) > Waffle.config.connection_attempt_timeout
            connect!
          end
        end
      end

      def subscribe(flow = 'events')
        db.subscribe(*flow) do |channel, message|
          yield(channel, Waffle.encoder.decode(message))
        end
      end

      private
      def connect!
        begin
          @@last_connection_attempt = Time.now
          @db = ::Redis.new(:url => Waffle.config.url)
        rescue
          nil
        end
      end
    end
  end
end
