module Waffle
  class Producer

    def publish(queue = 'unknown', message = nil)
      @strategy.publish queue, message
    end

  end
end
