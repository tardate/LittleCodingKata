#include <iostream>
#include <memory>
#include <string>

#include <grpc++/grpc++.h>

#include "explainer.grpc.pb.h"

using grpc::Channel;
using grpc::ClientContext;
using grpc::Status;
using explainer::ExplainerRequest;
using explainer::ExplainerReply;
using explainer::ShiFu;

class ExplainerClient {
  public:
    ExplainerClient(std::shared_ptr<Channel> channel)
      : stub_(ShiFu::NewStub(channel)) {}

  std::string TellMeWhy(const std::string& problem) {
    ExplainerRequest request;
    request.set_problem(problem);

    ExplainerReply reply;

    ClientContext context;

    Status status = stub_->TellMeWhy(&context, request, &reply);

    if (status.ok()) {
      return reply.explanation();
    } else {
      return "RPC failed";
    }
  }

 private:
  std::unique_ptr<ShiFu::Stub> stub_;
};

int main(int argc, char** argv) {
  ExplainerClient client(grpc::CreateChannel("localhost:50051", grpc::InsecureChannelCredentials()));
  std::string problem;
  if(argc>1) {
    problem = argv[1];
  } else {
    problem = "help";
  }
  std::string reply = client.TellMeWhy(problem);
  std::cout << reply << std::endl;
  return 0;
}
