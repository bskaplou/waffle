module Waffle
  class Consumer

    def subscribe(queue = 'unknown')
      @strategy.subscribe queue
    end

  end
end
