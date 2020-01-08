#! /usr/bin/env ruby
require 'minitest/autorun'
require './random_mac'

class RandomMacTest < Minitest::Test
  def test_valid_mac_structure
    mac = random_mac
    assert_match /[\da-f]{2}-[\da-f]{2}-[\da-f]{2}-[\da-f]{2}/, mac
  end

  def test_no_two_the_same
    mac1 = random_mac
    mac2 = random_mac
    refute_equal mac1, mac2
  end

  def test_default_OUI
    mac = random_mac
    assert_equal '00-16-3e', mac[0..7]
  end

  def test_override_OUI
    custom_oui = '11-22-33'
    mac = random_mac(custom_oui)
    assert_equal custom_oui, mac[0..7]
  end
end
