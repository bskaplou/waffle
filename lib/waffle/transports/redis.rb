module Waffle
  module Transports
    class Redis < Base
      attr_reader :db

      protected
      def publish_impl(flow = 'events', message = '')
        db.publish(flow, encoder.encode(message))
      end

      def subscribe_impl(flow = 'events')
        db.subscribe(*flow) do |on|
          on.message do |channel, message|
            yield(channel, encoder.decode(message))
          end
        end
      end

      def connection_exceptions
        [Errno::ECONNREFUSED, Errno::ECONNRESET]
      end

      def do_connect
        @db = ::Redis.new(:url => config.url)
      end
    end
  end
end
