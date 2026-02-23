require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/'

set :port, 4567
set :bind, '0.0.0.0'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end
