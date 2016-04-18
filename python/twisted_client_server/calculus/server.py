"""Calculation server.

A TCP server that offers the services of the Calculation class.
"""
from twisted.protocols import basic
from twisted.internet import protocol
from calculus.base import Calculation


class CalculationProxy(object):
    def __init__(self):
        self.calc = Calculation()
        for operation_name in ['add', 'subtract', 'multiply', 'divide']:
            setattr(self, 'remote_%s' % operation_name, getattr(self.calc, operation_name))


class RemoteCalculationProtocol(basic.LineReceiver):
    def __init__(self):
        self.proxy = CalculationProxy()


    def lineReceived(self, line):
        """Simple line-oriented service protocol.

        Given a line, it attempts to process it using the Calculation class and send the result.
        """
        operation_name, a, b = line.split()
        a = int(a)
        b = int(b)
        operation = getattr(self.proxy, 'remote_%s' % (operation_name,))
        result = operation(a, b)
        self.sendLine(str(result))


class RemoteCalculationFactory(protocol.Factory):
    protocol = RemoteCalculationProtocol


def main():
    """Startup the server."""
    from twisted.internet import reactor
    from twisted.python import log
    import sys
    log.startLogging(sys.stdout)
    reactor.listenTCP(0, RemoteCalculationFactory())
    reactor.run()

if __name__ == "__main__":
    main()
