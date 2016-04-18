from calculus.client import RemoteCalculationClient
from twisted.trial import unittest
from twisted.test import proto_helpers


class ClientCalculationTestCase(unittest.TestCase):

    def setUp(self):
        self.transport = proto_helpers.StringTransport()
        self.protocol = RemoteCalculationClient()
        self.protocol.makeConnection(self.transport)

    def try_operation(self, operation, a, b, expected):
        """Try an operation using the remote client.

        The tests now return a Deferred object, and the assertion is done in a callback.

        The important thing to do here is to not forget to return the Deferred.
         If you do, your tests will pass even if nothing is asserted.
        """
        deferred = getattr(self.protocol, operation)(a, b)
        self.assertEqual(self.transport.value(), '%s %d %d\r\n' % (operation, a, b))
        self.transport.clear()
        deferred.addCallback(self.assertEqual, expected)
        self.protocol.dataReceived("%d\r\n" % (expected,))
        return deferred

    def test_add(self):
        return self.try_operation('add', 7, 6, 13)

    def test_subtract(self):
        return self.try_operation('subtract', 82, 78, 4)

    def test_multiply(self):
        return self.try_operation('multiply', 2, 8, 16)

    def test_divide(self):
        return self.try_operation('divide', 14, 3, 4)
