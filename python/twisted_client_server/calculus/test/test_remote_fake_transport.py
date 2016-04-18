from calculus.server import RemoteCalculationFactory
from twisted.trial import unittest
from twisted.test import proto_helpers


class RemoteCalculationFakeTransportTestCase(unittest.TestCase):
    """Tests the RemoteCalculationFactory over a fake transport.

    Testing protocols without the use of real network connections is both simple and recommended when testing Twisted code.
    """

    def setUp(self):
        factory = RemoteCalculationFactory()
        self.protocol = factory.buildProtocol(('127.0.0.1', 0))
        self.transport = proto_helpers.StringTransport()
        self.protocol.makeConnection(self.transport)


    def try_perform(self, operation, a, b, expected):
        """Try an +operation+ on +a+ and +b+, returning the +expected+ result.

        The call to +dataReceived+ simulates data arriving on the network transport.

        This essentially tricks the server into thinking it has received the operation and the arguments over the network
        """
        self.protocol.dataReceived('%s %d %d\r\n' % (operation, a, b))
        self.assertEqual(int(self.transport.value()), expected)


    def test_add(self):
        return self.try_perform('add', 7, 6, 13)


    def test_subtract(self):
        return self.try_perform('subtract', 82, 78, 4)


    def test_multiply(self):
        return self.try_perform('multiply', 2, 8, 16)


    def test_divide(self):
        return self.try_perform('divide', 14, 3, 4)
