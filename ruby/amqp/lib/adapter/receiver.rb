class Adapter::Receiver
  def run!
    EventMachine.run do
      connection = AMQP.connect(Adapter::AmqpConfig::CONNECTION_OPTIONS.dup)

      puts "Connecting to AMQP broker:"
      puts ".. running #{AMQP::VERSION} version of the AMQP gem"
      puts ".. listening on queue #{Adapter::AmqpConfig::QUEUE}"
      puts ".. send 'exit' to terminate"

      channel = AMQP::Channel.new(connection)
      queue = channel.queue(Adapter::AmqpConfig::QUEUE, auto_delete: true)
      exchange = channel.default_exchange

      queue.subscribe do |payload|
        puts "Received a message: #{payload}"

        if payload == 'exit'
          puts 'Disconnecting...'
          connection.close {
            EventMachine.stop { exit }
          }
        end
      end
    end
  end
end
