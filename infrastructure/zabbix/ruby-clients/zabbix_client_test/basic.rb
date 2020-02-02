require 'io/console'
require 'zabbix/client'

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

client = Zabbix::Client.new(api_url)

if token
  puts "Connecting with auth token"
  client.auth = token
else
  puts "Connecting with username/password"
  client.user.login(user: username, password: password)
end

puts "\nconnected, api version: #{client.apiinfo.version}"
puts "auth token: #{client.auth}"

puts "\nGetting the list of host groups:"
puts client.hostgroup.get

puts "\nGetting a specific host:"
puts client.host.get(filter: { 'host' => 'zabbix-app' })
