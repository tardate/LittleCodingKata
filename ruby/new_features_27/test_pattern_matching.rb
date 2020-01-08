#! /usr/bin/env ruby
require 'minitest/autorun'

class TestPatternMatching < Minitest::Test
  def test_version
    assert_equal '2.7.0', RUBY_VERSION
  end

  def test_with_case
    evaluator = ->(data) do
      case data
      in [a, [b, *c]]
        [a, b, c]
      in version: '1', db:
        "v1 with db: #{db}"
      in String
        'just a plain old string'
      in String => user, String => password
        "(uid:#{user}, pwd:#{password})"
      else
        'no match'
      end
    end
    assert_equal [0, 1, [2, 3]], evaluator.call([0, [1, 2, 3]])
    assert_equal 'just a plain old string', evaluator.call('abc')
    assert_equal 'v1 with db: db1', evaluator.call({ version: '1', db: 'db1'})
    assert_equal '(uid:joe, pwd:monkey)', evaluator.call(['joe', 'monkey'])
    assert_equal 'no match', evaluator.call(99)
  end
end
