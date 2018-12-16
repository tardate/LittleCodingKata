#! /usr/bin/env ruby
require 'minitest/autorun'
require 'json'

class PrettyGenerateTest < Minitest::Test

  def subject(value)
    JSON.pretty_generate(value)
  end

  def test_with_hash
    assert_equal subject({a: 1}), %({\n  "a": 1\n})
  end

  def test_with_array
    assert_equal subject([1, 2]), %([\n  1,\n  2\n])
  end

  # def test_with_integer
  #   if JSON::VERSION_MAJOR >= 2
  #     assert_equal subject(42), "42"
  #   else
  #     assert_raises(JSON::GeneratorError) do
  #       subject(42)
  #     end
  #   end
  # end

  # def test_with_nil
  #   if JSON::VERSION_MAJOR >= 2
  #     assert_equal subject(nil), "null"
  #   else
  #     assert_raises(JSON::GeneratorError) do
  #       subject(nil)
  #     end
  #   end
  # end

  if JSON::VERSION_MAJOR >= 2

    def test_with_integer
      assert_equal subject(42), "42"
    end

    def test_with_nil
      assert_equal subject(nil), "null"
    end

  else

    def test_with_integer
      assert_raises(JSON::GeneratorError) do
        subject(42)
      end
    end

    def test_with_nil
      assert_raises(JSON::GeneratorError) do
        subject(nil)
      end
    end

  end

end

puts "\n\n*** RUNNING TESTS WITH JSON v#{JSON::VERSION} ***\n\n"
