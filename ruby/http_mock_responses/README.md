# #216 HTTP Mock Responses

Using Sinatra to craft simple HTTP web responses for mock integration testing.

## Notes

Sometimes you need a web site to return a specific response - for example certain error codes and payloads.
Maybe one is trying to diagnose or verify a correct behaviour.

Sinatra is a very convenient way to whip up something suitable.
A couple of lines of code may be all that is required.

The [app.rb](./app.rb) script is a very simple Sinatra app that will run by default on `http://localhost:4567`.
In a few lines, it shows how to handle arbitrary GET and PORT requests and render a suitable response.

The parameters provided in the URL of the request will determine the HTTP status code and content type of the response.

## Running the Example

To run the app locally:

    $ gem install bundler
    $ bundle install
    $ ruby app.rb
    [2018-05-01 21:09:53] INFO  WEBrick 1.3.1
    [2018-05-01 21:09:53] INFO  ruby 2.3.3 (2016-11-21) [x86_64-darwin14]
    == Sinatra (v2.0.1) has taken the stage on 4567 for development with backup from WEBrick
    [2018-05-01 21:09:53] INFO  WEBrick::HTTPServer#start: pid=32888 port=4567


## Making Arbitrary GET Requests

Making a GET request to `http://localhost:4567/:code:.:format:` will respond according to the `:code:` and `:format:` specified. Where:

* `:code:` sets the HTTP Status of the response e.g. 200, 401, 500
* `:format:` sets the content type of the response: html, txt, xml or json are supported

Examples with `curl`:

    $ curl -v http://localhost:4567/500.json
    *   Trying ::1...
    * Connected to localhost (::1) port 4567 (#0)
    > GET /500.json HTTP/1.1
    > Host: localhost:4567
    > User-Agent: curl/7.43.0
    > Accept: */*
    >
    < HTTP/1.1 500 Internal Server Error
    < Content-Type: application/json
    < Content-Length: 53
    < X-Content-Type-Options: nosniff
    < Server: WEBrick/1.3.1 (Ruby/2.3.3/2016-11-21)
    < Date: Tue, 01 May 2018 13:02:59 GMT
    < Connection: Keep-Alive
    <
    {
      "message": "Returning code 500 in json format"
    }
    * Connection #0 to host localhost left intact


## Making Arbitrary POST Requests

Making a POST request to `http://localhost:4567/:code:.:format:` will respond according to the `:code:` and `:format:` specified. Where:

* `:code:` sets the HTTP Status of the response e.g. 200, 401, 500
* `:format:` sets the content type of the response: html, txt, xml or json are supported

Examples with `curl`:


    $ curl -v -X POST -H "Accept: application/xml" -H "Content-Type: application/xml" -d "<data></data>" http://localhost:4567/410.xml
    *   Trying ::1...
    * Connected to localhost (::1) port 4567 (#0)
    > POST /410.xml HTTP/1.1
    > Host: localhost:4567
    > User-Agent: curl/7.43.0
    > Accept: application/xml
    > Content-Type: application/xml
    > Content-Length: 13
    >
    * upload completely sent off: 13 out of 13 bytes
    < HTTP/1.1 410 Gone
    < Content-Type: application/xml;charset=utf-8
    < Content-Length: 78
    < X-Content-Type-Options: nosniff
    < Server: WEBrick/1.3.1 (Ruby/2.3.3/2016-11-21)
    < Date: Tue, 01 May 2018 13:12:05 GMT
    < Connection: Keep-Alive
    <
    <response>
      <message>Returning code 410 in xml format</message>
    </response>"
    * Connection #0 to host localhost left intact



## Credits and References
* [Sinatra](http://sinatrarb.com/)
* [curl](https://curl.haxx.se/)
* [HTTP status codes](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)
