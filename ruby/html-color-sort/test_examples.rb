#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = %w[
    FFFF00
    000000
    000080
    800000
    FFFFFF
    008000
    0000FF
    008080
    00FF00
    00FFFF
    800080
    808000
    808080
    C0C0C0
    FF0000
    FF00FF
  ]
  EG1_EXPECTED = %w[
    000000
    000080
    0000FF
    008000
    008080
    00FF00
    00FFFF
    800000
    800080
    808000
    808080
    C0C0C0
    FF0000
    FF00FF
    FFFF00
    FFFFFF
  ]
  EG2 = %w[01 04 02 03]
  EG2_EXPECTED = %w[000001 000002 000003 000004]
  EG3 = %w[04 01 03 02]
  EG3_EXPECTED = %w[000001 000002 000003 000004]

  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = HexStringSorter.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_postman_eg1
    exec_test_case(:postman)
  end

  def test_postman_eg2
    exec_test_case(:postman, EG2, EG2_EXPECTED)
  end

  def test_postman_eg3
    exec_test_case(:postman, EG3, EG3_EXPECTED)
  end

  def test_merge_sort_eg1
    exec_test_case(:merge_sort)
  end

  def test_merge_sort_eg2
    exec_test_case(:merge_sort, EG2, EG2_EXPECTED)
  end

  def test_merge_sort_eg3
    exec_test_case(:merge_sort, EG3, EG3_EXPECTED)
  end
end


class TestNumericInput < Minitest::Test
  def exec_test_case(input)
    HexStringSorter.new(input).numeric_input
  end

  def test_accepts_plain_hex_strings
    assert_equal [0, 128, 8388608, 16777215], exec_test_case(%w[000000 000080 800000 FFFFFF])
  end

  def test_ignores_leading_hash
    assert_equal [0, 128, 8388608, 16777215], exec_test_case(%w[#000000 #000080 #800000 #FFFFFF])
  end

  def test_ignores_leading_0x
    assert_equal [0, 128, 8388608, 16777215], exec_test_case(%w[0x000000 0x000080 0x800000 0xFFFFFF])
  end

  def test_ignores_trailing_h
    assert_equal [0, 128, 8388608, 16777215], exec_test_case(%w[000000h 000080h 800000h FFFFFFh])
  end
end
