require 'bunny'

module Waffle
  module Strategies
    module RabbitMQ
      class Base

        def initialize(configuration = nil)
          @bunny = Bunny.new configuration.url
          @bunny.start
        end

      end

      class Producer < RabbitMQ::Base

        def publish(flow = 'events', message = '')
          @exchange = @bunny.exchange exchange
          @exchange.publish message
        end

      end

      class Consumer < RabbitMQ::Base

        def subscribe(flow = 'events')
          @exchange = @bunny.exchange exchange
          @queue    = @bunny.queue '', :durable => true, :auto_delete => true
          @queue.bind @exchange

          @queue.subscribe do |message|
            yield message[:payload]
          end
        end

      end
    end
  end
end
