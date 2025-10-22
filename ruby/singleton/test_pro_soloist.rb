#! /usr/bin/env ruby
require 'minitest/autorun'
require './pro_soloist'

class ProSoloistTest < Minitest::Test
  def setup
    @a, @b = ProSoloist.instance, ProSoloist.instance
  end

  def test_same_object_id
    assert_equal @a.object_id, @b.object_id
  end

  def test_eq
    assert @a == @b
  end

  def test_to_s
    assert_equal "Pro Soloist [object_id=#{@a.object_id}]", @a.to_s
  end
end
