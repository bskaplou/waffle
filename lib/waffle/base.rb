module Waffle
  class Base

    def initialize(transport = nil)
      @transport = transport
    end

    def publish(flow = 'events', message = '')
      begin
        @transport.publish flow, message
      rescue
        nil
      end
    end

    def subscribe(flow = '', &block)
      @transport.subscribe flow, &block
    end

  end
end
