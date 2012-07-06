module Waffle
  module Transports
    class Redis < Base
      attr_reader :db

      def publish(flow = 'events', message = '')
        db.publish(flow, Waffle.encoder.encode(message))
      end

      def subscribe(flow = 'events')
        db.subscribe(*flow) do |on|
          on.message do |channel, message|
            yield(channel, Waffle.encoder.decode(message))
          end
        end
      end

      def connection_exceptions
        [Errno::ECONNREFUSED, Errno::ECONNRESET]
      end

      protected
      def do_connect
        @db = ::Redis.new(:url => Waffle.config.url)
      end
    end
  end
end
