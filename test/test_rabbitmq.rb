require 'test/unit'
require 'waffle/configuration'
require 'waffle/strategies/rabbitmq'

class RabbitmqTest < Test::Unit::TestCase

  def test_bad_initialization
    assert_raise ArgumentError do
      Waffle::Strategies::Rabbitmq.new
    end

    assert_raise ArgumentError do
      Waffle::Strategies::Rabbitmq.new 'crap'
    end
  end

  def test_good_initialization
    assert_nothing_raised do
      Waffle::Strategies::Rabbitmq.new Waffle::Configuration.new
    end
  end

end
