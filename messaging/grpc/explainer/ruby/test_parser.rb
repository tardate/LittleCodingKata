#! /usr/bin/env ruby
require 'minitest/autorun'
require './lib/parser'


class ParserTest < Minitest::Test

  def setup
    @subject = Parser.new('honestly, because of REASON and REASON')
  end

  def test_help
    parser = Parser.new('help')
    assert_equal parser.help, parser.explanation
  end

  def test_components
    components = @subject.components
    assert_instance_of Array, components
    assert_equal 'LCD screen', components.first
  end

  def test_random_component
    selected = @subject.random_component
    assert_includes @subject.components, selected
  end

  def test_excuses
    excuses = @subject.excuses
    assert_instance_of Array, excuses
    assert_equal 'impedance in the COMPONENT', excuses.first
  end

  def test_random_excuse
    selected = @subject.random_excuse
    assert_includes @subject.excuses, selected
  end

  def test_generate_reason_substitutes_components
    5.times do
      reason = @subject.generate_reason
      refute_includes reason, 'COMPONENT'
    end
  end

  def test_explanation_substitutes_reason_and_components
    5.times do
      explanation = @subject.explanation
      refute_includes explanation, 'COMPONENT'
      refute_includes explanation, 'REASON'
    end
  end

end
