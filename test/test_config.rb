require 'test/unit'
require 'waffle/config'

class RabbitmqTest < Test::Unit::TestCase

  def test_config_options_mapping
    assert_equal Waffle::Config.transport, 'rabbitmq'
    assert_equal Waffle::Config.encoder, 'json'
  end

end
