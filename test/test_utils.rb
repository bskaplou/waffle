require 'test/unit'
require 'waffle/utils'

class UtilsTest < Test::Unit::TestCase

  def test_encode
    encoded_msg = Waffle::Utils.encode({'a' => 1, 'b' => 2})
    assert_equal('{"a":1,"b":2}', encoded_msg)
  end

  def test_decode
    decoded_msg = Waffle::Utils.decode('{"a":1,"b":2}')
    assert_equal({'a' => 1, 'b' => 2}, decoded_msg)
  end

end
