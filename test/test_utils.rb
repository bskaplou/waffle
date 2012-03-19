require 'test/unit'
require 'waffle/utils'

class UtilsTest < Test::Unit::TestCase

  def test_encode
    encoded_msg = Waffle::Utils.encode({'b' => 1, 'a' => 2})
    assert_equal encoded_msg, '{"a":1,"b":2}'
  end

  def test_decode
    decoded_msg = Waffle::Utils.decode '{"a":1,"b":2}'
    assert_equal decoded_msg, {'a' => 1, 'b' => 2}
  end

end
