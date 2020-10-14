# Sinatra Echo Tools

A Sinatra app that provides a number of remote request debugging tools, and can be run with Docker

## Notes

This is a simple Sinatra application that responds with a number of diagnostic calls:

* `/time/now` - Returns server UTC time in iso8601 format.
* `/ip` - Returns the IP address of the calling device (as it appears to the server).
* `/request` - Returns the request details as seen on the server, including request headers and the Sinatra/Rack environment.
* `/:code:` - Returns a response with the specified HTTP status code (`:code:`, e.g. 200, 401, 500)

By default, they all return an HTML response, but adding a path extension can be used to return a plain text, XML or JSON response:

* `/:path:.txt` - with a plain text response
* `/:path:.json` - with a JSON response
* `/:path:.xml` - with an XML response
* `/:path:.html` - with an HTML response

Loading the root page returns a menu:

![landing](./assets/landing.png?raw=true)

## Running the Example

To run the app locally:

    $ gem install bundler
    $ bundle install
    $ ruby app.rb
    == Sinatra (v2.0.1) has taken the stage on 4567 for development with backup from Thin
    Thin web server (v1.7.2 codename Bachmanity)
    Maximum connections set to 1024
    Listening on localhost:4567, CTRL+C to stop


## Example Calls (Local Server)

Here are some examples of calling the status code endpoint with curl:

Default HTML format:

    $ curl -v localhost:4567/500.html
    *   Trying ::1...
    * TCP_NODELAY set
    * Connected to localhost (::1) port 4567 (#0)
    > GET /500.html HTTP/1.1
    > Host: localhost:4567
    > User-Agent: curl/7.54.0
    > Accept: */*
    >
    < HTTP/1.1 500 Internal Server Error
    < Content-Type: text/html;charset=utf-8
    < Content-Length: 218
    < X-XSS-Protection: 1; mode=block
    < X-Content-Type-Options: nosniff
    < X-Frame-Options: SAMEORIGIN
    < Connection: keep-alive
    < Server: thin
    <
    <html>
    <head>
      <title>Sinatra Echoplex</title>
      <link rel="stylesheet" type="text/css" href="/site.css">
    </head>
    <body>
      <h1>Custom Status Response</h1>
    <p>
      Returning code 500 in html format
    </p>
    </body>
    </html>

Plain text format:

    $ curl -v localhost:4567/500.txt
    *   Trying ::1...
    * TCP_NODELAY set
    * Connected to localhost (::1) port 4567 (#0)
    > GET /500.txt HTTP/1.1
    > Host: localhost:4567
    > User-Agent: curl/7.54.0
    > Accept: */*
    >
    < HTTP/1.1 500 Internal Server Error
    < Content-Type: text/plain;charset=utf-8
    < Content-Length: 32
    < X-Content-Type-Options: nosniff
    < Connection: keep-alive
    < Server: thin
    <
    Returning code 500 in txt format

XML format:

    $ curl -v localhost:4567/302.xml
    *   Trying ::1...
    * TCP_NODELAY set
    * Connected to localhost (::1) port 4567 (#0)
    > GET /302.xml HTTP/1.1
    > Host: localhost:4567
    > User-Agent: curl/7.54.0
    > Accept: */*
    >
    < HTTP/1.1 302 Moved Temporarily
    < Content-Type: application/xml;charset=utf-8
    < Content-Length: 77
    < X-Content-Type-Options: nosniff
    < Connection: keep-alive
    < Server: thin
    <
    <response>
      <message>Returning code 302 in xml format</message>
    </response>

JSON format:

    $ curl -v localhost:4567/502.json
    *   Trying ::1...
    * TCP_NODELAY set
    * Connected to localhost (::1) port 4567 (#0)
    > GET /502.json HTTP/1.1
    > Host: localhost:4567
    > User-Agent: curl/7.54.0
    > Accept: */*
    >
    < HTTP/1.1 502 Bad Gateway
    < Content-Type: application/json
    < Content-Length: 47
    < X-Content-Type-Options: nosniff
    < Connection: keep-alive
    < Server: thin
    <
    {"message":"Returning code 502 in json format"}


## Running with Docker

The [dockerfile](./dockerfile) and [dockerfile-compose.yml](./dockerfile-compose.yml) configurations are fairly straight-forward.

The main trick to ensure the Sinatra app can run from within Docker is to ensure it binds to the correct interface
(else it will only be available locally within the container!). The default binds to localhost.

This can be done in a few ways:

* `set :bind, '0.0.0.0'` in th application code
* `ruby app.rb -o 0.0.0.0` from the command line

In this case, I've done it with command line parameters in the dockerfile-compose configuration.

Running the app with docker:

    docker-compose build
    docker-compose up

Or to run in the background:

    $docker-compose up -d
    Starting sinatra_echo_web_1 ... done

    $ docker-compose logs
    Attaching to sinatra_echo_web_1
    web_1  | == Sinatra (v2.0.1) has taken the stage on 4567 for development with backup from Thin
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:46:34 +0000] "GET / HTTP/1.1" 200 2069 0.0145
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:46:34 +0000] "GET /site.css HTTP/1.1" 200 482 0.0008
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:46:34 +0000] "GET /favicon.ico HTTP/1.1" 0 71 0.0026
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:46:48 +0000] "GET / HTTP/1.1" 200 2069 0.0040
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:46:48 +0000] "GET /site.css HTTP/1.1" 200 482 0.0010
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:46:48 +0000] "GET /favicon.ico HTTP/1.1" 0 71 0.0006
    web_1  | 192.168.0.46 - - [21/Jul/2019:06:48:48 +0000] "GET /ip.txt HTTP/1.1" 200 12 0.0006
    web_1  | 172.18.0.1 - - [21/Jul/2019:06:48:54 +0000] "GET /ip.txt HTTP/1.1" 200 10 0.0006
    web_1  | == Sinatra (v2.0.1) has taken the stage on 4567 for development with backup from Thin

    $ docker-compose down
    Stopping sinatra_echo_web_1 ... done
    Removing sinatra_echo_web_1 ... done
    Removing network sinatra_echo_default

## Request IPs in a Docker Environment

When running the app in Docker, there's an interesting gotcha when it comes to identifying the
IP of the client. Consider these responses:

    $ curl 0.0.0.0/ip.txt
    172.18.0.1
    $ curl -H "X-Forwarded-For: 192.168.0.46" 0.0.0.0/ip.txt
    192.168.0.46

In the first case, the IP `172.18.0.1` is actually not the client IP address, but the address used by the Docker userland-proxy.
Docker has proxied the request, but not forwarded the original request. This is an issue that has been raised
on Docker for some time with no fix in sight (see
[here](https://github.com/docker/for-mac/issues/180) and
[here](https://github.com/docker/compose/issues/6021)
).

When running Docker in Linux, it is possible to bypass the userland-proxy and bind directly to the host interface (solving this issue).
This is descibed in the [docs](https://docs.docker.com/network/host/). However it does not work for Mac and Windows.

I have added support for [X-Forwarded-For](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For) headers in the app, as demonstrated above.
I have not tested this yet, but I suspect that as long as an IP load balancer (AWS Elastic LB or haproxy) sits in front of the dockerized application
it should be possible to have the `X-Forwarded-For` header inserted and forwarded.

## Credits and References

* [Sinatra Docs](http://sinatrarb.com/)
* [Sinatra API Docs](https://rubydoc.info/gems/sinatra/index)
* [TimeAPI app](http://timeapi.herokuapp.com/) with [source](https://github.com/progrium/timeapi) - similar example of a time service
* [ipecho.net](https://ipecho.net/) - a remote IP service. I can't find the source, but there's a [similar project on GitHub](https://github.com/wujiang/ip-echo)
* [X-Forwarded-For](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For)
* [Original ip is not passed to containers](https://github.com/docker/for-mac/issues/180) - docker issue
* [nginx cannot get to client IP ?](https://github.com/docker/compose/issues/6021) - docker/compose issue
* [Use host networking](https://docs.docker.com/network/host/) - docker docs
