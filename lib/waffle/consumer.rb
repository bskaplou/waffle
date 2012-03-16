module Waffle
  class Consumer < Base

    def subscribe(queue = '', &block)
      @strategy.subscribe queue, &block
    end

  end
end
