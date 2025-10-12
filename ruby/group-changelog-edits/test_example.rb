#!/usr/bin/env ruby
# frozen_string_literal: true
require 'minitest/autorun'
require './example'

class TestExample < Minitest::Test
  EG1 = [
    { "timestamp" => "2025-10-06T08:00:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:05:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:20:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:07:00Z", "component" => "Footer" },
    { "timestamp" => "2025-10-06T08:15:00Z", "component" => "Footer" }
  ]
  EG1_EXPECTED = [
    {
        "component" => "Footer",
        "start" => "2025-10-06T08:07:00Z",
        "end" => "2025-10-06T08:15:00Z"
    },
    {
        "component" => "Header",
        "start" => "2025-10-06T08:00:00Z",
        "end" => "2025-10-06T08:05:00Z"
    },
    {
        "component" => "Header",
        "start" => "2025-10-06T08:20:00Z",
        "end" => "2025-10-06T08:20:00Z"
    }
  ]
  EG2 = [
    { "timestamp" => "2025-10-06T08:05:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:06:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:14:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:16:00Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:16:10Z", "component" => "Header" },
    { "timestamp" => "2025-10-06T08:16:30Z", "component" => "Header" }
  ]
  EG2_EXPECTED = [
    {
      "component" => "Header",
      "start" => "2025-10-06T08:05:00Z",
      "end" => "2025-10-06T08:14:00Z"
    },
    {
      "component" => "Header",
      "start" => "2025-10-06T08:16:00Z",
      "end" => "2025-10-06T08:16:30Z"
    }
  ]


  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = ChangeLogGrouper.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_initial_solution_eg1
    exec_test_case(:initial_solution)
  end

  def test_initial_solution_eg2
    exec_test_case(:initial_solution, EG2, EG2_EXPECTED)
  end
end
