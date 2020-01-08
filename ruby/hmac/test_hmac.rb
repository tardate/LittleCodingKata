#! /usr/bin/env ruby
require 'minitest/autorun'
require './hmac'

class HmacTest < Minitest::Test
  def setup
    @key = "key"
    @data = "The quick brown fox jumps over the lazy dog"
  end

  def test_md5
    result = get_hmac_hexdigest("md5", @key, @data)
    assert_equal "80070713463e7749b90c2dc24911e275", result
  end

  def test_sha1
    result = get_hmac_hexdigest("sha1", @key, @data)
    assert_equal "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9", result
  end

  def test_sha256
    result = get_hmac_hexdigest("sha256", @key, @data)
    assert_equal "f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8", result
  end
end
