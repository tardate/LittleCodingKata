#! /usr/bin/env ruby
require 'drb'

class TestServer
  def log(message)
    STDERR.puts self.class.name,message
  end
  def run!(url)
    log "starting on #{url}.."
    DRb.start_service(url, self)
    DRb.thread.join
  end
  def doit
    log 'handling doit...'
    "Hello, Distributed World"
  end
end

server = TestServer.new
server.run! 'druby://localhost:9000'
