module Waffle
  class Consumer

    def subscribe(queue = '')
      @strategy.subscribe queue
    end

  end
end
