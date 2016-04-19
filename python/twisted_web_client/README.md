# Test-driving Web Clients with Twisted

Using twisted for web client requests can present an "unusual" testing challenge
because of the asynchronous (deferred) callback nature of twisted.
And the docs aren't that great.

So this is an exercise in writting a cannonical web client and testing it all ways I can think would normally be a "good idea":

* with real web requests, and the tests deal with deferred responses explicitly
* with real web requests, but inline callbacks
* with "mock web response", and the tests deal with deferred responses explicitly
* with "mock web response", but inline callbacks

## Running the Example

```
$ python timeapi/client.py
Response version: ('HTTP', 1, 1)
Response code: 200
Response phrase: OK
[('X-XSS-Protection', ['1; mode=block']),
 ('Server', ['thin 1.5.0 codename Knife']),
 ('Via', ['1.1 vegur']),
 ('Date', ['Mon, 18 Apr 2016 22:35:33 GMT']),
 ('X-Frame-Options', ['sameorigin']),
 ('Content-Type', ['text/html;charset=utf-8'])]
Response body:
2016-04-18T22:35:34+00:00
```

## Running Tests - Trial

```
$ trial timeapi/
timeapi.test.test_client_for_real
  TimeClientRealResponseTestCase
[...test output truncated...]

timeapi.test.test_client_mock_response
  TimeClientMockResponseTestCase
[...test output truncated...]

-------------------------------------------------------------------------------
Ran 4 tests in 1.662s

PASSED (successes=4)
```

## Running Tests - Nose

I wasn't sure if `nosetests` was going to work properly without explicitly using
[Twisted integration](http://nose.readthedocs.org/en/latest/api/twistedtools.html)
for nose.

But I haven't needed to make any changes yet ... tests run just fine with nose:

```
$ nosetests
..
----------------------------------------------------------------------
Ran 4 tests in 1.854s

OK
```

## About the timeapi server

I'm using a simple time service for testing. Here's what a raw call looks like:

```
$ curl -0 -i --raw http://www.timeapi.org/utc/now
HTTP/1.1 200 OK
Date: Mon, 18 Apr 2016 15:39:16 GMT
Connection: close
X-Frame-Options: sameorigin
X-Xss-Protection: 1; mode=block
Content-Type: text/html;charset=utf-8
Content-Length: 25
Server: thin 1.5.0 codename Knife
Via: 1.1 vegur

2016-04-18T15:39:16+00:00
```

## Credits and References
* [Twisted Site](https://twistedmatrix.com/trac/)
* [How can I write tests for code using twisted.web.client.Agent and its subclasses?](http://stackoverflow.com/questions/18386385/how-can-i-write-tests-for-code-using-twisted-web-client-agent-and-its-subclasses)
