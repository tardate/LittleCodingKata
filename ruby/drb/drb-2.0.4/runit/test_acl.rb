# acltest.rb - ACL unit test
# Copyright (c) 2000 Masatoshi SEKI
#
# acltest.rb is copyrighted free software by Masatoshi SEKI.
# You can redistribute it and/or modify it under the same terms as Ruby.

require 'runit/testcase'
require 'runit/cui/testrunner'
require 'acl'

class SampleHosts
  def initialize
    list = %w(127.0.0.1 localhost
              192.168.1.1 x68k.linux.or.jp
              192.168.1.2 lc630.macos.or.jp
              192.168.1.3 lib30.win32.or.jp
              192.168.1.4 ns00.linux.or.jp
              192.168.1.5 yum.macos.or.jp
              ::ffff:192.168.1.5 ipv6.macos.or.jp
              ::192.168.1.5 too.yumipv6.macos.or.jp
              192.168.1.254 comstarz.foo.or.jp)

    @hostlist = Array.new(list.size / 2)
    @hostlist.each_index do |idx|
      @hostlist[idx] = ["AF_INET", 10000, list[idx * 2 + 1], list[idx * 2]]
    end

    @hosts = Hash.new
    @hostlist.each do |h|
      @hosts[h[2].split('.')[0]] = h
    end
  end
  attr_reader(:hostlist, :hosts)
end


class ACLEntryTest < RUNIT::TestCase
  HOSTS = SampleHosts.new

  def setup
    @hostlist = HOSTS.hostlist
    @hosts = HOSTS.hosts
  end

  def test_all
    a = ACL::ACLEntry.new("*")
    b = ACL::ACLEntry.new("all")
    @hostlist.each do |h|
      assert(a.match(h))
      assert(b.match(h))
    end
  end

  def test_ip_v6
    a = ACL::ACLEntry.new('*:192.*.*.*')
    assert(! a.match(@hosts['localhost']))
    assert(! a.match(@hosts['yum']))
    assert(a.match(@hosts['ipv6']))
    assert(a.match(@hosts['too']))
  end

  def test_ip
    a = ACL::ACLEntry.new('192.*.*.*')
    assert(! a.match(@hosts['localhost']))
    assert(a.match(@hosts['yum']))

    a = ACL::ACLEntry.new('192.168.*.1')
    assert(! a.match(@hosts['localhost']))
    assert(! a.match(@hosts['yum']))
    assert(a.match(@hosts['x68k']))

    a = ACL::ACLEntry.new('192.168.1.*')
    assert(! a.match(@hosts['localhost']))
    assert(a.match(@hosts['yum']))
    assert(a.match(@hosts['x68k']))

    a = ACL::ACLEntry.new('92.*.*.*')
    assert(! a.match(@hosts['localhost']))
    assert(! a.match(@hosts['yum']))
    assert(! a.match(@hosts['x68k']))

    a = ACL::ACLEntry.new('127.*.*.1')
    assert(a.match(@hosts['localhost']))
    assert(! a.match(@hosts['yum']))
    assert(! a.match(@hosts['x68k']))
  end

  def test_name
    a = ACL::ACLEntry.new('*.jp')
    assert(! a.match(@hosts['localhost']))
    assert(a.match(@hosts['yum']))

    a = ACL::ACLEntry.new('yum.*.jp')
    assert(a.match(@hosts['yum']))
    assert(! a.match(@hosts['lc630']))

    a = ACL::ACLEntry.new('*.macos.or.jp')
    assert(a.match(@hosts['yum']))
    assert(a.match(@hosts['lc630']))
    assert(! a.match(@hosts['lib30']))
  end
end

class ACLListTest < RUNIT::TestCase
  HOSTS = SampleHosts.new

  def setup
    @hostlist = HOSTS.hostlist
    @hosts = HOSTS.hosts
  end

  private
  def build(list)
    acl= ACL::ACLList.new
    list.each do |s|
      acl.add s
    end
    acl
  end

  public
  def test_all_1
    a = build(%w(all))
    @hostlist.each do |h|
      assert(a.match(h))
    end
  end

  def test_all_2
    a = build(%w(localhost 127.*.*.* yum.* *))
    @hostlist.each do |h|
      assert(a.match(h))
    end
  end

  def test_1
    a = build(%w(192.*.*.1 yum.*.jp))
    assert(a.match(@hosts['yum']))
    assert(a.match(@hosts['x68k']))
    assert(! a.match(@hosts['lc630']))
  end

  def test_2
    a = build(%w(*.linux.or.jp))
    assert(!a.match(@hosts['yum']))
    assert(a.match(@hosts['x68k']))
    assert(!a.match(@hosts['lc630']))
  end
end

class ACLTest < RUNIT::TestCase
  HOSTS = SampleHosts.new

  def setup
    @hostlist = HOSTS.hostlist
    @hosts = HOSTS.hosts
  end

  def test_0
    a = ACL.new
    @hostlist.each do |h|
      assert(a.allow_addr?(h))
    end
  end

  def test_not_0
    a = ACL.new([], ACL::ALLOW_DENY)
    @hostlist.each do |h|
      assert(! a.allow_addr?(h))
    end
  end

  def test_1
    data = %w(deny all
              allow localhost
              allow x68k.*)

    a = ACL.new(data)
    assert(a.allow_addr?(@hosts['x68k']))
    assert(a.allow_addr?(@hosts['localhost']))
    assert(! a.allow_addr?(@hosts['lc630']))
  end

  def test_not_1
    data = %w(deny 192.*.*.*
              allow localhost
              allow x68k.*)

    a = ACL.new(data, ACL::ALLOW_DENY)
    assert(!a.allow_addr?(@hosts['x68k']))
    assert(a.allow_addr?(@hosts['localhost']))
    assert(! a.allow_addr?(@hosts['lc630']))
  end
end

if __FILE__ == $0
  RUNIT::CUI::TestRunner.run(ACLEntryTest.suite)
  RUNIT::CUI::TestRunner.run(ACLListTest.suite)
  RUNIT::CUI::TestRunner.run(ACLTest.suite)
end

  
