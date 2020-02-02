require 'io/console'
require 'zbxapi'

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

api_handle = ZabbixAPI.new(api_url, verify_ssl: true, http_timeout: 300)
api_handle.login(username, password)

puts "connected, api version: #{api_handle.API_version}"
puts "auth token: #{api_handle.auth}"

puts "\nGetting the list of host groups:"
puts api_handle.hostgroup.get({})

puts "\nGetting a specific host:"
puts api_handle.host.get(filter: { 'host' => 'zabbix-app' })
