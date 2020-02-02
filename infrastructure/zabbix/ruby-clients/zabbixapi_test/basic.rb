require 'io/console'
require 'zabbixapi'

def get_config
  token = ENV['ZABBIX_API_TOKEN']
  username = ENV['ZABBIX_API_USERNAME']
  password = ENV['ZABBIX_API_PASSWORD']

  unless username
    print "Enter username: "
    password = STDIN.noecho(&:gets).chomp
  end
  unless password
    print "Enter password for #{username}: "
    password = STDIN.noecho(&:gets).chomp
  end
  api_url = ENV['ZABBIX_API_URL'] || 'http://0.0.0.0:80/api_jsonrpc.php'
  [api_url, username, password, token]
end

api_url, username, password, token = get_config

api_handle = ZabbixApi.connect(url: api_url, user: username, password: password)

puts "connected, api version: #{api_handle.client.api_version}"
puts "auth token: #{api_handle.client.auth}"

puts "\nGetting the list of host groups:"
puts api_handle.hostgroups.get({})

puts "\nGetting a specific host:"
puts api_handle.hosts.get(filter: { 'host' => 'zabbix-app' })
