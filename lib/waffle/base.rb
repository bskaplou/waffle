module Waffle
  class Base

    def initialize(strategy = nil)
      @strategy = strategy
    end

    def publish(flow = 'events', message = '')
      @strategy.publish flow, message
    end

    def subscribe(flow = '', &block)
      @strategy.subscribe flow, &block
    end

  end
end
