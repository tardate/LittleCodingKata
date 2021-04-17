require 'sinatra'

set :public_folder, Proc.new { File.join(root, 'skin') }

get '/' do
  redirect '/index.html', 302
end
