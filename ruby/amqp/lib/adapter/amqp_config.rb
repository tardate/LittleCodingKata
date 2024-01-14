class Adapter::AmqpConfig
  CONNECTION_OPTIONS = {
    host: 'localhost',
    username: 'guest',
    password: 'guest'
  }.freeze
  
  QUEUE = 'lck.amqp.example'.freeze
end
