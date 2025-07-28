#! /usr/bin/env ruby
require 'minitest/autorun'
require './examples'


class TestExamples < Minitest::Test
  EG1 = [
    { "name" => "keycaps", "arrivalDays" => 1, "assemblyHours" => 2 },
    { "name" => "switches", "arrivalDays" => 2, "assemblyHours" => 3 },
    { "name" => "stabilizers", "arrivalDays" => 0, "assemblyHours" => 1 },
    { "name" => "PCB", "arrivalDays" => 1, "assemblyHours" => 4 },
    { "name" => "case", "arrivalDays" => 3, "assemblyHours" => 2 }
  ]
  EG1_EXPECTED = 74

  EG2 = [
    {"name"=>"part-a1", "arrivalDays"=>0, "assemblyHours"=>30},
    {"name"=>"part-a2", "arrivalDays"=>0, "assemblyHours"=>60},
    {"name"=>"part-b1", "arrivalDays"=>1, "assemblyHours"=>2},
    {"name"=>"part-b2", "arrivalDays"=>1, "assemblyHours"=>6}
  ]
  EG2_EXPECTED = 98

  def exec_test_case(algorithm, given=EG1, expected=EG1_EXPECTED)
    result = AssemblyPlanning.new(given).send(algorithm)
    if expected.nil?
      assert_nil result
    else
      assert_equal expected, result
    end
  end

  def test_spt_with_example_1
    exec_test_case(:spt)
  end

  def test_spt_with_example_2
    exec_test_case(:spt, EG2, EG2_EXPECTED)
  end
end
