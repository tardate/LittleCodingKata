#! /usr/bin/env ruby
require 'minitest/autorun'
require './challenge'


class TestChallenge < Minitest::Test
  def test_example1
    assert canSeat(
      ["Ang", "Ben", "Cam"],
      [["Ang", "Ben"], ["Ben", "Cam"]]
    )
  end

  def test_example2
    refute canSeat(
      ["Ang", "Ben", "Cam"],
      [["Ang", "Ben"], ["Ben", "Cam"], ["Cam", "Ang"]]
    )
  end

  def test_example3
    assert canSeat(
      ["Ang", "Ben", "Cam"],
      []
    )
  end

  def test_ignore_ordering_default
    assert canSeat(
      ["A", "B", "C"],
      [["A", "B"], ["A", "C"]]
    )
  end

  def test_ignore_ordering_mixed
    assert canSeat(
      ["A", "B", "C"],
      [["A", "B"], ["C", "A"]]
    )
  end
end
