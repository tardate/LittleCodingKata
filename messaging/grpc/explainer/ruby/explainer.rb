#!/usr/bin/env ruby

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'explainer_services'
require 'parser'

class ShiFuServer < Explainer::ShiFu::Service
  def tell_me_why(explainer_request, _unused_call)
    Explainer::ExplainerReply.new(
      explanation: Parser.new(explainer_request.problem).explanation
    )
  end
end

def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(ShiFuServer)
  puts "ShiFu is waiting to explain all of your problems..."
  s.run_till_terminated
end

main
