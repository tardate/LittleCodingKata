#! /usr/bin/env ruby
require 'minitest/autorun'
require './ipv4info_netaddr'

class TestPublicIpWithCidr < Minitest::Test
  def setup
    @subject = Ipv4Info.new('198.51.100.14/24')
  end

  def test_has_correct_ipv4
    assert @subject.ipv4?
  end

  def test_has_correct_private
    assert !@subject.private?
  end

  def test_has_correct_cidr
    assert_equal 24, @subject.cidr
  end

  def test_has_correct_netmask
    assert_equal '255.255.255.0', @subject.netmask
  end

  def test_has_correct_network_address
    assert_equal '198.51.100.0', @subject.network_address
  end

  def test_has_correct_total_addresses
    assert_equal 256, @subject.total_addresses
  end

  def test_has_correct_total_hosts
    assert_equal 254, @subject.total_hosts
  end
end

class TestPrivateIpWithCidr < Minitest::Test
  def setup
    @subject = Ipv4Info.new('192.168.10.10/30')
  end

  def test_has_correct_ipv4
    assert @subject.ipv4?
  end

  def test_has_correct_private
    assert @subject.private?
  end

  def test_has_correct_cidr
    assert_equal 30, @subject.cidr
  end

  def test_has_correct_netmask
    assert_equal '255.255.255.252', @subject.netmask
  end

  def test_has_correct_network_address
    assert_equal '192.168.10.8', @subject.network_address
  end

  def test_has_correct_total_addresses
    assert_equal 4, @subject.total_addresses
  end

  def test_has_correct_total_hosts
    assert_equal 2, @subject.total_hosts
  end
end

class TestPublicIpWithoutCidr < Minitest::Test
  def setup
    @subject = Ipv4Info.new('198.51.100.14')
  end

  def test_has_correct_ipv4
    assert @subject.ipv4?
  end

  def test_has_correct_private
    assert !@subject.private?
  end

  def test_has_correct_cidr
    assert_equal 32, @subject.cidr
  end

  def test_has_correct_netmask
    assert_equal '255.255.255.255', @subject.netmask
  end

  def test_has_correct_network_address
    assert_equal '198.51.100.14', @subject.network_address
  end

  def test_has_correct_total_addresses
    assert_equal 1, @subject.total_addresses
  end

  def test_has_correct_total_hosts
    assert_equal 1, @subject.total_hosts
  end
end
