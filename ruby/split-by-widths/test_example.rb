#! /usr/bin/env ruby
require 'minitest/autorun'
require './example'


class TestExample < Minitest::Test
  def exec_test_case(input, widths, expected)
    result = split_by_widths(input, widths)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_given_example
    exec_test_case(
      'Supercalifragilisticexpialidocious',
      [5, 9, 4],
      ['Super', 'califragi', 'list', 'icex', 'pial', 'idoc', 'ious']
    )
  end

  def test_short_final_segment
    exec_test_case(
      'Supercalifragilisticexpialidocious',
      [5, 9, 6],
      ['Super', 'califragi', 'listic', 'expial', 'idocio', 'us']
    )
  end

  def test_minimum_widths
    exec_test_case(
      'abcdefg',
      [1],
      ['a', 'b', 'c', 'd', 'e', 'f', 'g']
    )
  end

  def test_excess_widths
    exec_test_case(
      'abcdefghij',
      [3, 2, 4, 6, 6],
      ['abc', 'de', 'fghi', 'j']
    )
  end
end
