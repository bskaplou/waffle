module Waffle
  class Producer < Base

    def publish(message = '')
      @strategy.publish message
    end

  end
end
