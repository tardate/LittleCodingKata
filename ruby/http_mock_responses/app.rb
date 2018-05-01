require 'sinatra'

# some simple hard-coded repsonse rendering..
def generate_response(code, format)
  message = "Returning code #{code} in #{format} format"
  response_data = case format
  when "txt"
    content_type 'text/plain'
    message
  when "xml"
    content_type 'application/xml'
    <<-EOS
<response>
  <message>#{message}</message>
</response>"
    EOS
  when "json"
    content_type 'application/json'
    %[{\n  "message": "#{message}"\n}]
    <<-EOS
{
  "message": "#{message}"
}
    EOS
  else
    content_type 'text/html'
    <<-EOS
<html>
<body>
    #{message}
</body>
</html>
EOS
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
