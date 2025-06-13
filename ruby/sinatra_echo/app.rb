require 'sinatra'
require 'time'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

# Return the current time
get %r{/time/now\.?([\w]*)} do |format|
  @time = Time.now.utc.iso8601
  case format
  when 'txt'
    content_type 'text/plain'
    @time
  when 'json'
    content_type 'application/json'
    { time: @time }.to_json
  when 'xml'
    content_type 'application/xml'
    erb :'time.xml', layout: false
  else
    erb :time
  end
end

# Return the client IP
get %r{/ip\.?([\w]*)} do |format|
  @ip = request.env["HTTP_X_FORWARDED_FOR"] || request.ip
  case format
  when 'txt'
    content_type 'text/plain'
    "#{@ip}"
  when 'json'
    content_type 'application/json'
    { ip: @ip }.to_json
  when 'xml'
    content_type 'application/xml'
    erb :'ip.xml', layout: false
  else
    erb :ip
  end
end

# Return the request info
get %r{/request\.?([\w]*)} do |format|
  @env = request.env
  case format
  when 'txt'
    content_type 'text/plain'
    "#{@env}"
  when 'json'
    content_type 'application/json'
    @env.to_json
  when 'xml'
    content_type 'application/xml'
    erb :'env.xml', layout: false
  else
    erb :env
  end
end

# some simple hard-coded response rendering..
def generate_response(code, format)
  @message = "Returning code #{code} in #{format} format"
  response_data = case format
  when "txt"
    content_type 'text/plain'
    @message
  when "json"
    content_type 'application/json'
    { message: @message }.to_json
  when "xml"
    content_type 'application/xml'
    erb :'status.xml', layout: false
  else
    erb :status
  end
  [code.to_i, response_data]
end

# handle arbitrary GET requests
get '/:code.:format' do
  generate_response params['code'], params['format']
end

# handle arbitrary POST requests
post '/:code.:format' do
  generate_response params['code'], params['format']
end

# everything else shows the main page
get '/*' do
  erb :index
end
