require 'test/unit'
require 'waffle/config'

class RabbitmqTest < Test::Unit::TestCase

  def test_config_options_mapping
    assert_equal Waffle::Config.transport, 'rabbitmq'
    assert_equal Waffle::Config.encoder, 'json'
  end
  
  def test_setup_config
    Waffle::Config.setup!('transport' => 'Blablabla', 'encoder' => 'xml', 'url' => nil)
    assert_equal Waffle::Config.transport, 'Blablabla'
    assert_equal Waffle::Config.encoder, 'xml'
  end
end
