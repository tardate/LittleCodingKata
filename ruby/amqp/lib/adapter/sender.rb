class Adapter::Sender
  def send(message)
    message ||= "Hello #{Time.now}"

    EventMachine.run do
      connection = AMQP.connect(Adapter::AmqpConfig::CONNECTION_OPTIONS.dup)
      channel = AMQP::Channel.new(connection)
      queue = channel.queue(Adapter::AmqpConfig::QUEUE, auto_delete: true)

      puts "sending: #{message} [queue: #{queue.name}, AMQP: #{AMQP::VERSION}]"
      exchange = channel.default_exchange
      exchange.publish message, routing_key: queue.name, persistent: true, nowait: false do
        connection.close { EventMachine.stop }
      end
    end
  end
end
