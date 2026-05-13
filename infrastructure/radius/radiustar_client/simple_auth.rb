#!/usr/bin/env ruby
require 'radiustar'
require 'digest'
require 'openssl'

require './patch-dictionary-loading.rb'
require './patch-packet-encoding.rb'
require './patch-message-authentication.rb'

class SimpleAuth
  attr_accessor :username, :password, :secret, :nas_ip
  attr_accessor :dict, :local_ip

  def initialize(username, password, secret, nas_ip = nil)
    self.username = username
    self.password = password
    self.secret = secret
    self.nas_ip = nas_ip || '127.0.0.1'
    self.local_ip = '127.0.0.1'
    load_dictionaries
  end

  def load_dictionaries
    self.dict = Radiustar::Dictionary.new(File.join(Dir.pwd, 'dictionaries'))
  end

  def auth
    puts "Sending Auth-Request to '#{nas_ip}'.."
    auth_custom_attr = {
      'Framed-Address'  => local_ip,
      'NAS-Port'        => 0,
      'NAS-Port-Type'   => 'Ethernet'
    }
    req = Radiustar::Request.new(nas_ip, { :dict => dict })
    result = req.authenticate(username, password, secret, auth_custom_attr)
    puts "Got reply: #{result[:code]}"
    result
  end

  def demo_accounting(auth_reply)
    return unless auth_reply[:code] == 'Access-Accept'

    req = Radiustar::Request.new(nas_ip + ':1813', { :dict => dict })

    acct_custom_attr = {
      'Framed-Address'  => local_ip,
      'NAS-Port'        => 0,
      'NAS-Port-Type'   => 'Ethernet',
      'Acct-Session-Time' => 0
    }

    timings = Time.now
    reply = req.accounting_start('bob', 'testing123', '123456', acct_custom_attr)

    sleep(rand 5)
    acct_custom_attr['Acct-Session-Time'] = Time.now - timings
    reply = req.accounting_update('bob', 'testing123', '123456', acct_custom_attr)

    sleep(rand 5)
    acct_custom_attr['Acct-Session-Time'] = Time.now - timings
    reply = req.accounting_stop('bob', 'testing123', '123456', acct_custom_attr)
  end
end

if __FILE__==$PROGRAM_NAME
  (puts "Usage: ruby #{$0} (username) (password) (secret) [nas-ip - default 127.0.0.1]"; exit) unless ARGV.length > 2
  client = SimpleAuth.new(*ARGV)
  client.auth
end
