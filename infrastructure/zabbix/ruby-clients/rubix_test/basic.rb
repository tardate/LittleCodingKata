require 'io/console'
require 'rubix'

def get_config
  unless (username = ENV['ZABBIX_API_USERNAME'])
    print "Enter username: "
    password = STDIN.noecho(&:gets).chomp
  end
  unless (password = ENV['ZABBIX_API_PASSWORD'])
    print "Enter password for #{username}: "
    password = STDIN.noecho(&:gets).chomp
  end
  api_url = ENV['ZABBIX_API_URL'] || 'http://0.0.0.0:80/api_jsonrpc.php'
  [api_url, username, password]
end

def render_response(response)
  case
  when response.has_data?
    puts response.result
  when response.success?
    puts "No data"
  else
    puts response.error_message
  end
end

Rubix.connect(*get_config)

puts "\nGetting the list of host groups:"
render_response Rubix.connection.request('hostgroup.get', {})

puts "\nGetting a specific host:"
render_response Rubix.connection.request('host.get', 'filter' => { 'host' => 'zabbix-app' })

# Rubix::HostGroup.find(name: 'Zabbix servers') # the ORM is buggy. this throws exception
