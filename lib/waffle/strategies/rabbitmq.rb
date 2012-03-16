require 'bunny'

module Waffle
  module Strategies
    module RabbitMQ
      class Base

        def initialize(url = nil, exchange = 'unknown_exchange')
          @bunny    = Bunny.new url
          @exchange = @bunny.exchange exchange
        end

      end

      class Producer < Base

        def initialize(url = nil, exchange = 'unknown_exchnage')
          super url, exchange
        end

        def publish(message = '')
          @exchange.publish message
        end

      end

      class Consumer < Base

        def subscribe(queue = '')
          # TODO: Subscribe code here
        end

      end
    end
  end
end
