# ngrok

Creating publically-accessible URLs for services running locally.

## Notes

When developing software it is often really convenient to be able to
run a publically-accessible URL for the code when it is still in development or testing.
A common scenario is when developing intergrations with commercial cloud services.

One could deploy the software to a cloud instance, or jump through the hoops of setting up a publically accessible server.
These invove the hassle of deploying software, setting up servers and making sure on stays safe and secure.

In many cases, [ngrok.com](https://ngrok.com/) provides a much more convenient solution:
It essentially sets up a personal proxy service with unique publically accessible URLs (HTTP and HTTPS) that
routes traffic to a local port. It does this without needing to change any firewall or NAT settings

### Installation

Installation is a simple exeutable download:

* [download](https://ngrok.com/download) a zip file
* unpack it and put the ngrok executable somewhere convenient

It runs:

    $ ngrok version
    ngrok version 2.3.40

## Configuration

Requires an [account](https://dashboard.ngrok.com/signup)

    $ ngrok authtoken <token>



### Simple Example

Running [HTTP Mock Responses](../../ruby/http_mock_responses) on [http://localhost:4567](http://localhost:4567).
Here's an example response when called directly on localhost:

    $ curl http://localhost:4567/200.json
    {
      "message": "Returning code 200 in json format"
    }

Now starting up ngrok for this port

    $ ngrok http 4567

![ngrok_4567](./assets/ngrok_4567.png?raw=true)

Now can access vai HTTP over the open net using the auto-generated URL:

    $ curl http://d7ee-2406-3003-2060-3754-935-f710-c2cc-d2fb.ngrok.io/200.json
    {
      "message": "Returning code 200 in json format"
    }

Or HTTPS/TLS:

    $ curl https://d7ee-2406-3003-2060-3754-935-f710-c2cc-d2fb.ngrok.io/200.json
    {
      "message": "Returning code 200 in json format"
    }


The assigned URLs will recycle on every restart of ngrok, however a paid account can get persistent domain names and other features

## Credits and References

* [ngrok.com](https://ngrok.com/)
