from pprint import pformat

from twisted.internet import reactor
from twisted.web.client import Agent
from twisted.web.client import readBody
from twisted.web.http_headers import Headers


class TimeClient(Agent):

    def get_time(self):
        deferred = self.request(
            'GET',
            'http://www.timeapi.org/utc/now',
            Headers({
              'User-Agent': ['Twisted Web Client Example'],
              'Accept': ['text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'],
            }),
            None
        )
        deferred.addCallback(self.on_response)
        return deferred

    def on_response(self, response):
        print 'Response version:', response.version
        # print 'Response code:', response.code
        # print 'Response phrase:', response.phrase
        # print pformat(list(response.headers.getAllRawHeaders()))
        deferred = readBody(response)
        deferred.addCallback(self.on_body)
        return deferred

    def on_body(self, body):
        print 'Response body:'
        print body
        return body


def on_shutdown(ignored):
    reactor.stop()


def main():
    time_client = TimeClient(reactor)
    deferred = time_client.get_time()
    deferred.addBoth(on_shutdown)
    reactor.run()

if __name__ == "__main__":
    main()
