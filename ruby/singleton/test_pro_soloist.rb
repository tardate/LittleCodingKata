#! /usr/bin/env ruby
require 'minitest/autorun'
require './pro_soloist'

class ProSoloistTest < Minitest::Test
  def test_repeated_access
    soloist1 = ProSoloist.instance
    soloist2 = ProSoloist.instance
    assert_equal soloist1.object_id, soloist2.object_id
  end

  def test_to_s
    soloist = ProSoloist.instance
    assert_equal "Pro Soloist [object_id=#{soloist.object_id}]", soloist.to_s
  end
end
