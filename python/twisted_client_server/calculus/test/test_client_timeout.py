from calculus.client_with_timeout import RemoteCalculationClientWithTimeout
from calculus.client_with_timeout import ClientTimeoutError
from twisted.internet import task
from twisted.trial import unittest
from twisted.test import proto_helpers


class ClientTimeoutTestCase(unittest.TestCase):

    def setUp(self):
        self.transport = proto_helpers.StringTransport()
        self.clock = task.Clock()
        self.protocol = RemoteCalculationClientWithTimeout()
        self.protocol.callLater = self.clock.callLater
        self.protocol.makeConnection(self.transport)

    def test_add_timeout(self):
        deferred = self.protocol.add(9, 4)
        self.assertEqual(self.transport.value(), 'add 9 4\r\n')
        self.clock.advance(self.protocol.timeOut)
        return self.assertFailure(deferred, ClientTimeoutError)
