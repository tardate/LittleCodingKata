#! /usr/bin/env ruby
require 'minitest/autorun'
require './amateur_soloist'

class AmateurSoloistTest < Minitest::Test
  def test_repeated_access
    soloist1 = AmateurSoloist.instance
    soloist2 = AmateurSoloist.instance
    assert_equal soloist1.object_id, soloist2.object_id
  end

  def test_to_s
    soloist = AmateurSoloist.instance
    assert_equal "Amateur Soloist [object_id=#{soloist.object_id}]", soloist.to_s
  end
end
