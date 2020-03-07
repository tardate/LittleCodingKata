require 'io/console'
require 'zabbix/client'

# Returns config from ENV or manual input if required
def get_config
  api_url = ENV['ZABBIX_API_URL'] || 'http://0.0.0.0:80/api_jsonrpc.php'
  username = ENV['ZABBIX_API_USERNAME']
  password = ENV['ZABBIX_API_PASSWORD']
  token = ENV['ZABBIX_API_TOKEN']

  unless token
    unless username
      print "Enter username: "
      password = STDIN.noecho(&:gets).chomp
    end
    unless password
      print "Enter password for #{username}: "
      password = STDIN.noecho(&:gets).chomp
    end
  end
  [api_url, username, password, token]
end

# Returns a signed-in client
def get_client
  api_url, username, password, token = get_config
  client = Zabbix::Client.new(api_url)

  if token
    STDERR.puts "Connecting with auth token"
    client.auth = token
  else
    STDERR.puts "Connecting with username/password"
    client.user.login(user: username, password: password)
  end

  STDERR.puts "API version: #{client.apiinfo.version}. Connected with token: #{client.auth}"
  client
end
