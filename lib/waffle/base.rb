module Waffle
  class Base

    def initialize(strategy = nil)
      @strategy = strategy
    end

    def publish(flow = 'events', message = '')
      begin
        @strategy.publish flow, message
      rescue
        nil
      end
    end

    def subscribe(flow = '', &block)
      @strategy.subscribe flow, &block
    end

  end
end
