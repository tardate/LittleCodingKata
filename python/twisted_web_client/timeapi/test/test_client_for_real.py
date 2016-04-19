from twisted.internet import reactor
from twisted.web.client import Agent
from twisted.internet.defer import inlineCallbacks
from twisted.trial import unittest
from timeapi.client import TimeClient


class TimeClientRealResponseTestCase(unittest.TestCase):

    def setUp(self):
        self.time_client = TimeClient(reactor)

    def test_get_time_with_deferred(self):
        deferred = self.time_client.get_time()
        deferred.addCallback(self.assertRegexpMatches, r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{2}:\d{2}')
        return deferred

    @inlineCallbacks
    def test_get_time_with_inline_callback(self):
        response = yield self.time_client.get_time()
        self.assertRegexpMatches(response, r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\+\d{2}:\d{2}')
