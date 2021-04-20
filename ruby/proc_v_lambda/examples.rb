#! /usr/bin/env ruby
require 'minitest/autorun'

class TestProcsAndLambdas < Minitest::Test
  EXPECTED_RESULT = 12

  def add(x, y)
    x + y
  end

  def test_use_parens_for_stabby_lambda_definition_with_parameters
    handle = ->(x, y) { add(x, y) }
    assert_equal EXPECTED_RESULT, handle.call(6, 6)

    not_this_way = -> x, y { add(x, y) }
    assert_equal EXPECTED_RESULT, not_this_way.call(6, 6)
  end

  def test_no_parens_for_stabby_lambda_definition_without_parameters
    handle = -> { add(6, 6) }
    assert_equal EXPECTED_RESULT, handle.call

    not_this_way = ->() { add(6, 6) }
    assert_equal EXPECTED_RESULT, not_this_way.call
  end

  def test_use_lamdba_for_multi_line
    handle = lambda do |weeks, days|
      tmp = weeks * 7
      tmp + days
    end
    assert_equal EXPECTED_RESULT, handle.call(1, 5)

    not_this_way = ->(weeks, days) do
      tmp = weeks * 7
      tmp + days
    end
    assert_equal EXPECTED_RESULT, not_this_way.call(1, 5)
  end

  def test_use_kernel_proc_instead_of_proc_new
    handle = proc { add(6, 6) }
    assert_equal EXPECTED_RESULT, handle.call

    not_this_way = Proc.new { add(6, 6) }
    assert_equal EXPECTED_RESULT, not_this_way.call
  end

  def test_use_explicit_call
    handle = ->(x) { add(x, 6) }
    assert_equal EXPECTED_RESULT, handle.call(6)
    # not this way:
    assert_equal EXPECTED_RESULT, handle[6]
    # or this way:
    assert_equal EXPECTED_RESULT, handle.(6)
  end

  def test_proc_and_lambda_are_all_procs
    proc_handle = proc { add(6, 6) }
    lambda_handle = lambda { add(6, 6) }

    assert_equal proc_handle.class, lambda_handle.class
  end

  def test_proc_and_lambda_are_different_flavours_of_proc
    proc_handle = proc { add(6, 6) }
    lambda_handle = lambda { add(6, 6) }

    assert_equal false, proc_handle.lambda?
    assert_equal true, lambda_handle.lambda?
  end

  def test_stabby_returns_a_lambda
    handle = -> { add(6, 6) }
    assert_equal true, handle.lambda?
  end

  def test_lambdas_check_the_number_of_arguments
    handle = ->(x, y) { add(x || 6, y || 6) }
    assert_equal EXPECTED_RESULT, handle.call(6, 6)
    assert_raises(ArgumentError) { handle.call(6) }
    assert_raises(ArgumentError) { handle.call }
  end

  def test_procs_dont_check_the_number_of_arguments
    handle = proc { |x, y| add(x || 6, y || 6) }
    assert_equal EXPECTED_RESULT, handle.call(6, 6)
    assert_equal EXPECTED_RESULT, handle.call(6)
    assert_equal EXPECTED_RESULT, handle.call
  end

  def lambda_wrapper
    handle = -> { return add(3, 3) }
    result = handle.call
    result + 6
  end

  def test_lambdas_return_to_calling_context
    assert_equal EXPECTED_RESULT, lambda_wrapper
  end

  def proc_wrapper
    handle = proc { return add(6,6) }
    handle.call
    -1
  end

  def test_procs_return_from_calling_context
    assert_equal EXPECTED_RESULT, proc_wrapper
  end
end
