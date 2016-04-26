from __future__ import print_function
from sys import argv
from grpc.beta import implementations

import explainer_pb2

_TIMEOUT_SECONDS = 10


def run(problem):
  channel = implementations.insecure_channel('localhost', 50051)
  stub = explainer_pb2.beta_create_ShiFu_stub(channel)
  response = stub.TellMeWhy(explainer_pb2.ExplainerRequest(problem=problem), _TIMEOUT_SECONDS)
  print(response.explanation)


if __name__ == '__main__':
  run(argv[1] if len(argv) > 1 else 'help')
