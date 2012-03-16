module Waffle
  class Producer

    def publish(message = '')
      @strategy.publish message
    end

  end
end
