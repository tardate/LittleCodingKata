require 'io/console'
require 'zabby'

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

api_handle = Zabby.init do
  set :server => api_url
  set :user => username
  set :password => password
  login
end

# puts api_handle.run { Zabby::APIInfo.version({}) } # not handled correctly
puts "auth token: #{api_handle.connection.auth}"

puts "\nGetting the list of host groups:"
puts api_handle.run { Zabby::Hostgroup.get({}) }

puts "\nGetting a specific host:"
puts api_handle.run { Zabby::Host.get 'filter' => { 'host' => 'zabbix-app' } }

