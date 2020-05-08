#! /usr/bin/env ruby
require 'minitest/autorun'
require 'uri'
require "addressable/uri"
require "addressable/template"


class TestDecomposition < Minitest::Test
  def given
    'http://usr:pwd@www.foo.com/path/to/posts.json?id=30&limit=5#time=1305298413'
  end

  def expect
    {
      scheme: 'http',
      host: 'www.foo.com',
      path: '/path/to/posts.json',
      query: 'id=30&limit=5',
      fragment: 'time=1305298413',
      absolute: true,
      user: 'usr',
      password: 'pwd',
      userinfo: 'usr:pwd'
    }
  end

  def test_uri
    uri = URI(given)
    assert_equal expect[:scheme], uri.scheme
    assert_equal expect[:host], uri.host
    assert_equal expect[:path], uri.path
    assert_equal expect[:query], uri.query
    assert_equal expect[:fragment], uri.fragment
    assert_equal expect[:absolute], uri.absolute
    assert_equal expect[:user], uri.user
    assert_equal expect[:password], uri.password
    assert_equal expect[:userinfo], uri.userinfo
  end

  def test_addressable
    uri = Addressable::URI.parse(given)
    assert_equal expect[:scheme], uri.scheme
    assert_equal expect[:host], uri.host
    assert_equal expect[:path], uri.path
    assert_equal expect[:query], uri.query
    assert_equal expect[:fragment], uri.fragment
    assert_equal expect[:absolute], uri.absolute?
    assert_equal expect[:user], uri.user
    assert_equal expect[:password], uri.password
    assert_equal expect[:userinfo], uri.userinfo
    assert_equal true, uri.ip_based?
    assert_equal 80, uri.default_port
    assert_equal 80, uri.inferred_port
    assert_equal 'com', uri.tld
    assert_equal 'foo.com', uri.domain
    assert_equal 'http://usr:pwd@www.foo.com', uri.site
    assert_equal 'posts.json', uri.basename
    assert_equal '.json', uri.extname
  end
end


class TestComposition < Minitest::Test
  def expect
    'http://usr:pwd@www.foo.com/path/to/posts.json?id=30&limit=5#time=1305298413'
  end

  def given
    {
      scheme: 'http',
      host: 'www.foo.com',
      port: nil,
      path: '/path/to/posts.json',
      query: 'id=30&limit=5',
      fragment: 'time=1305298413',
      userinfo: 'usr:pwd'
    }
  end

  def test_uri_generic
    # new(scheme, userinfo, host, port, registry, path, opaque, query, fragment, parser = DEFAULT_PARSER, arg_check = false)
    uri = URI::Generic.new(given[:scheme], given[:userinfo], given[:host], given[:port], nil, given[:path], false, given[:query], given[:fragment])
    assert_equal expect, uri.to_s
  end

  def test_uri_generic_build
    uri = URI::Generic.build(given)
    assert_equal expect, uri.to_s
  end

  def test_uri_http
    uri = URI::HTTP.build(given)
    assert_equal expect, uri.to_s
  end

  def test_addressable
    uri = Addressable::URI.new(given)
    assert_equal expect, uri.to_s
  end
end


class TestTemplates < Minitest::Test
  def test_expand
    template = Addressable::Template.new('http://{host}/{?query*}')
    uri = template.expand({
      'host' => 'alpha.beta.com',
      'query' => {
        'foo' => 'bar',
        'color' => 'red'
      }
    })
    assert_equal 'http://alpha.beta.com/?foo=bar&color=red', uri.to_s
  end

  def test_extract
    template = Addressable::Template.new('http://{host}{/segments*}/{?one,two,bogus}{#fragment}')
    uri = Addressable::URI.parse('http://example.com/a/b/c/?one=1&two=2#foo')
    expect = {
      "host"=>"example.com",
      "segments"=>["a", "b", "c"],
      "one"=>"1", "two"=>"2", "bogus"=>nil,
      "fragment"=>"foo"
    }
    assert_equal expect, template.extract(uri)
  end
end
