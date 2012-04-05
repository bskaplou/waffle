module Waffle
  class Base

    def initialize(transport = nil)
      @transport = transport
    end

    def publish(flow = 'events', message = '')
      @transport.publish flow, message
    end

    def subscribe(flow = '', &block)
      @transport.subscribe flow, &block
    end

  end
end
