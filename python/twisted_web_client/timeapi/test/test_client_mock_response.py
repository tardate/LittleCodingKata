from twisted.internet import reactor
from twisted.web.client import Agent
from twisted.internet.defer import inlineCallbacks
from twisted.trial import unittest
from twisted.test import proto_helpers
from twisted.internet.defer import Deferred
from twisted.internet.error import ProcessDone
from twisted.internet.error import ConnectionDone
from twisted.python.failure import Failure
from timeapi.client import TimeClient

class MockReason(object):

    def check(self, ignored):
        return True

class MockResponse(object):

    def __init__(self, response_string):
        self.response_string = response_string
        self.version = ('HTTP', 1, 1)
        self.code = '200'
        self.phrase = 'OK'

    def deliverBody(self, protocol):
        protocol.dataReceived(self.response_string)
        # protocol.connectionLost(ConnectionDone())
        # ^ I thought this should work. But the new web client wants to be able to call +check+ on the reason.
        # That seems unlike the way the twisted tests assert it should work.
        # Strange - not sure if a twisted bug or my poor knowledge.
        #
        # protocol.connectionLost(Failure(ConnectionDone()))
        # ^ this "works" but incorrectly ends with error
        #
        # So using a mock reason for now:
        protocol.connectionLost(MockReason())


def mock_request(self, method, uri, headers=None, bodyProducer=None):
    response_example = "2016-04-18T15:39:16+00:00"
    deferred = Deferred()
    reactor.callLater(0, deferred.callback, MockResponse(response_example))
    return deferred


class TimeClientMockResponseTestCase(unittest.TestCase):

    def setUp(self):
        self.time_client = TimeClient(reactor)
        self.time_client.request = mock_request

    def test_get_time_with_deferred(self):
        deferred = self.time_client.get_time()
        deferred.addCallback(self.assertEqual, "2016-04-18T15:39:16+00:00")
        return deferred

    @inlineCallbacks
    def test_get_time_with_inline_callback(self):
        response = yield self.time_client.get_time()
        self.assertEqual(response, "2016-04-18T15:39:16+00:00")
