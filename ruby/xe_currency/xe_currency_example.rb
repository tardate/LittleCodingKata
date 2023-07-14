#! /usr/bin/env ruby
#
require 'xe_currency'

class Converter
  attr_accessor :operation
  attr_accessor :to_currency
  attr_accessor :from_currency

  def initialize(args)
    case args.length
    when 1
      self.operation = "get_#{args[0]}"
    when 3
      self.operation = "get_#{args[1]}"
      self.from_currency = args[0]
      self.to_currency = args[2]
    end
  end

  def usage
    puts <<-EOS

    Usage:

      ruby #{$0} account_info
      ruby #{$0} <from_currency> to <to_currency>

    Required environment variables:

      XE_API_ID  : #{api_id}
      XE_API_KEY : #{api_key}

    EOS
  end

  def client
    @client ||= XeCurrency::Client.new(account_api_id: api_id, account_api_key: api_key)
  end

  def api_id
    @api_id ||= ENV['XE_API_ID']
  end

  def api_key
    @api_key ||= ENV['XE_API_KEY']
  end

  def valid?
    api_id && api_key && operation
  end

  def invoke
    send(operation)
  end

  def get_to
    client.fetch_rate(to_currency, from_currency)
  end
end


if __FILE__==$PROGRAM_NAME
  converter = Converter.new(ARGV)
  if converter.valid?
    puts converter.invoke
  else
    converter.usage
  end
end
