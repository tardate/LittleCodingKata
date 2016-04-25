#!/usr/bin/env ruby

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'explainer_services'

def main
  stub = Explainer::ShiFu::Stub.new('localhost:50051', :this_channel_is_insecure)
  problem = ARGV.size > 0 ?  ARGV[0] : 'help'
  puts stub.tell_me_why(Explainer::ExplainerRequest.new(problem: problem)).explanation
end

main
