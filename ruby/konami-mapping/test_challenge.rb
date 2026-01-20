#!/usr/bin/env ruby
# frozen_string_literal: true
require 'minitest/autorun'
require './challenge'


class TestChallenge < Minitest::Test
  def test_example_a
    input = "xx2233454590yy11110"
    result = konamiMapping(input)
    expected = { "0" => "A", "2" => "U", "3" => "D", "4" => "L", "5" => "R", "9" => "B" }
    assert_equal expected, result
  end

  def test_example_b
    input = "sduwahoda22ii0d0dbn"
    result = konamiMapping(input)
    expected = { "0" => "L", "2" => "U", "i" => "D", "d" => "R", "b" => "B", "n" => "A" }
    assert_equal expected, result
  end

  def test_no_solution
    input = "sduwahoda22ii"
    assert_nil konamiMapping(input)
  end
end

class TestApplyMapping < Minitest::Test
  def test_example_a
    input = "xx2233454590yy11110"
    mapping = { "0" => "A", "2" => "U", "3" => "D", "4" => "L", "5" => "R", "9" => "B" }
    result = apply_mapping(input, mapping)
    expected = "xxUUDDLRLRBAyy1111A"
    assert_equal expected, result
  end

  def test_example_b
    input = "sduwahoda22ii0d0dbn"
    mapping = { "0" => "L", "2" => "U", "i" => "D", "d" => "R", "b" => "B", "n" => "A" }
    result = apply_mapping(input, mapping)
    expected = "sRuwahoRaUUDDLRLRBA"
    assert_equal expected, result
  end
end

class TestPatternSignature < Minitest::Test
  def test_konami_code
    input = "UUDDLRLRBA"
    result = pattern_signature(input)
    expected = [0, 0, 1, 1, 2, 3, 2, 3, 4, 5]
    assert_equal expected, result
  end

  def test_example_a
    input = "2233454590"
    result = pattern_signature(input)
    expected = [0, 0, 1, 1, 2, 3, 2, 3, 4, 5]
    assert_equal expected, result
  end

  def test_example_b
    input = "22ii0d0dbn"
    result = pattern_signature(input)
    expected = [0, 0, 1, 1, 2, 3, 2, 3, 4, 5]
    assert_equal expected, result
  end
end
