require 'test/unit'
require 'mocha'
require 'bunny'
require 'waffle/transports/rabbitmq'

class RabbitmqTest < Test::Unit::TestCase

  def test_publish
    Bunny.setup nil
    Bunny::Exchange.any_instance.stubs(:publish).returns(nil)
    assert_equal nil, Waffle::Transports::Rabbitmq.new.publish('events', 'message')
  end

  def test_subscribe
    Bunny.setup nil
    Bunny::Queue.any_instance.stubs(:subscribe).returns(nil)
    assert_equal nil, Waffle::Transports::Rabbitmq.new.subscribe{ |m| puts m }
  end

end
