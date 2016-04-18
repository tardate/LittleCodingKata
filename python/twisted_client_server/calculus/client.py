"""Calculation client.

Works with the remote Calculation server.
"""
from twisted.protocols import basic
from twisted.internet import defer


class RemoteCalculationClient(basic.LineReceiver):

    def __init__(self):
        self.results = []

    def lineReceived(self, line):
        deferred = self.results.pop(0)
        deferred.callback(int(line))

    def remote_operation(self, op, a, b):
        deferred = defer.Deferred()
        self.results.append(deferred)
        line = "%s %d %d" % (op, a, b)
        self.sendLine(line)
        return deferred

    def add(self, a, b):
        return self.remote_operation("add", a, b)

    def subtract(self, a, b):
        return self.remote_operation("subtract", a, b)

    def multiply(self, a, b):
        return self.remote_operation("multiply", a, b)

    def divide(self, a, b):
        return self.remote_operation("divide", a, b)
