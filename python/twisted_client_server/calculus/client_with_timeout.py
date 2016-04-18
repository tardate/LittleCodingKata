"""Calculation client.

Works with the remote Calculation server with timeout support.
"""
from twisted.protocols import basic
from twisted.internet import defer
from twisted.internet import reactor


class ClientTimeoutError(Exception):
    pass


class RemoteCalculationClientWithTimeout(basic.LineReceiver):

    callLater = reactor.callLater
    timeOut = 60

    def __init__(self):
        self.results = []

    def _cancel(self, deferred):
        deferred.errback(ClientTimeoutError())

    def lineReceived(self, line):
        deferred, call_id = self.results.pop(0)
        call_id.cancel()
        deferred.callback(int(line))

    def remote_operation(self, op, a, b):
        deferred = defer.Deferred()
        call_id = self.callLater(self.timeOut, self._cancel, deferred)
        self.results.append((deferred, call_id, ))
        line = "%s %d %d" % (op, a, b)
        self.sendLine(line)
        return deferred
        d = defer.Deferred()

    def add(self, a, b):
        return self.remote_operation("add", a, b)

    def subtract(self, a, b):
        return self.remote_operation("subtract", a, b)

    def multiply(self, a, b):
        return self.remote_operation("multiply", a, b)

    def divide(self, a, b):
        return self.remote_operation("divide", a, b)
