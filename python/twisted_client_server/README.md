# Basic Twisted Client-Server with Tests

Twisted is an event-driven networking engine written in Python.

This is an invetsigation of test-driving custom client-server code with twisted,
following the examples from the
[Test-driven development with Twisted](https://twistedmatrix.com/documents/15.5.0/core/howto/trial.html)
tutorial.

## Installing and Running the Tests

```
$ pip install -r requirements.txt
$ nosetests
.................
----------------------------------------------------------------------
Ran 17 tests in 0.145s

OK
```


## Using the Calculus Server

```
$ export PYTHONPATH="$PYTHONPATH:`pwd`/calculus"
$ python calculus/server.py
2016-04-18 20:47:08+0800 [-] Log opened.
2016-04-18 20:47:08+0800 [-] RemoteCalculationFactory starting on 58522
2016-04-18 20:47:08+0800 [-] Starting factory <__main__.RemoteCalculationFactory instance at 0x10a4fb488>
```

in another window:

```
$ telnet localhost 58522
Trying 127.0.0.1...
Connected to localhost.
Escape character is '^]'.
add 4123 9423
13546
```

or with netcat (since telnet becoming vanishingly rare!)

```
$  nc -c localhost 58522
subtract 12345 4123
8222
add 4123 8222
12345
```

## Credits and References

* [Twisted Site](https://twistedmatrix.com/trac/)
* [Test-driven development with Twisted](https://twistedmatrix.com/documents/15.5.0/core/howto/trial.html)
* [netcat](http://netcat.sourceforge.net/)
