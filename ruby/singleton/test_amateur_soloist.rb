#! /usr/bin/env ruby
require 'minitest/autorun'
require './amateur_soloist'

class AmateurSoloistTest < Minitest::Test
  def setup
    @a, @b = AmateurSoloist.instance, AmateurSoloist.instance
  end

  def test_same_object_id
    assert_equal @a.object_id, @b.object_id
  end

  def test_eq
    assert @a == @b
  end

  def test_to_s
    assert_equal "Amateur Soloist [object_id=#{@a.object_id}]", @a.to_s
  end
end
