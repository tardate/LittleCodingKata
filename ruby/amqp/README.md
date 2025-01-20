# #274 AMQP with Ruby

Using the amqp EventMachine-based RabbitMQ client.

## Notes

The [amqp](https://rubygems.org/gems/amqp) gem is an EventMachine-based RabbitMQ client.

It has since been retired in favour of the [Bunny](http://rubybunny.info) gem.

### Message Receiver

The [receiver.rb](./bin/receiver.rb) script listens for messages and terminates when it gets the message 'exit'

    $ bin/receiver.rb 
    Connecting to AMQP broker:
    .. running 1.8.0 version of the AMQP gem
    .. listening on queue lck.amqp.example
    .. send 'exit' to terminate
    Received a message: test
    Received a message: test2
    Received a message: exit
    Disconnecting...

### Message Publisher

The [send.rb](./bin/send.rb) script publishes a message on the queue

    $ ./send.rb test
    sending: test [queue: lck.amqp.example, AMQP: 1.8.0]
    $ ./send.rb test2
    sending: test2 [queue: lck.amqp.example, AMQP: 1.8.0]
    $ ./send.rb exit
    sending: exit [queue: lck.amqp.example, AMQP: 1.8.0]

### RabbitMQ Server

These examples are run against a docker-hosted RabbitMQ server.
Running docker image `rabbitmq:3` with default config:

    $ docker run -p 5672:5672 --rm --name my-rabbit rabbitmq:3
    ...
    2024-01-14 06:17:07.845791+00:00 [info] <0.230.0>  Starting RabbitMQ 3.12.12 on Erlang 25.3.2.8 [jit]
    2024-01-14 06:17:07.845791+00:00 [info] <0.230.0>  Copyright (c) 2007-2023 Broadcom Inc and/or its subsidiaries
    2024-01-14 06:17:07.845791+00:00 [info] <0.230.0>  Licensed under the MPL 2.0. Website: https://rabbitmq.com

      ##  ##      RabbitMQ 3.12.12
      ##  ##
      ##########  Copyright (c) 2007-2023 Broadcom Inc and/or its subsidiaries
      ######  ##
      ##########  Licensed under the MPL 2.0. Website: https://rabbitmq.com

      Erlang:      25.3.2.8 [jit]
      TLS Library: OpenSSL - OpenSSL 3.1.4 24 Oct 2023
      Release series support status: supported

      Doc guides:  https://rabbitmq.com/documentation.html
      Support:     https://rabbitmq.com/contact.html
      Tutorials:   https://rabbitmq.com/getstarted.html
      Monitoring:  https://rabbitmq.com/monitoring.html

      Logs: <stdout>

      Config file(s): /etc/rabbitmq/conf.d/10-defaults.conf
                      /etc/rabbitmq/conf.d/20-management_agent.disable_metrics_collector.conf

      Starting broker...2024-01-14 06:17:07.849232+00:00 [info] <0.230.0> 
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>  node           : rabbit@9d35ed036e68
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>  home dir       : /var/lib/rabbitmq
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>  config file(s) : /etc/rabbitmq/conf.d/10-defaults.conf
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>                 : /etc/rabbitmq/conf.d/20-management_agent.disable_metrics_collector.conf
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>  cookie hash    : wL4JeU5He2nZd7qCdQ3cKA==
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>  log(s)         : <stdout>
    2024-01-14 06:17:07.849232+00:00 [info] <0.230.0>  data dir       : /var/lib/rabbitmq/mnesia/rabbit@9d35ed036e68
    ...
    2024-01-14 06:17:09.190057+00:00 [info] <0.632.0> Prometheus metrics: HTTP (non-TLS) listener started on port 15692
    2024-01-14 06:17:09.190099+00:00 [info] <0.601.0> Ready to start client connection listeners
    2024-01-14 06:17:09.190714+00:00 [info] <0.676.0> started TCP listener on [::]:5672
     completed with 3 plugins.
    2024-01-14 06:17:09.236632+00:00 [info] <0.601.0> Server startup complete; 3 plugins started.
    2024-01-14 06:17:09.236632+00:00 [info] <0.601.0>  * rabbitmq_prometheus
    2024-01-14 06:17:09.236632+00:00 [info] <0.601.0>  * rabbitmq_management_agent
    2024-01-14 06:17:09.236632+00:00 [info] <0.601.0>  * rabbitmq_web_dispatch
    2024-01-14 06:17:09.390631+00:00 [info] <0.9.0> Time to start RabbitMQ: 3077838 us

    ...
    2024-01-14 06:18:35.115804+00:00 [info] <0.679.0> accepting AMQP connection <0.679.0> (192.168.65.1:39507 -> 172.17.0.2:5672)
    2024-01-14 06:18:35.119788+00:00 [info] <0.679.0> connection <0.679.0> (192.168.65.1:39507 -> 172.17.0.2:5672): user 'guest' authenticated and granted access to vhost '/'
    2024-01-14 06:19:07.084759+00:00 [info] <0.717.0> accepting AMQP connection <0.717.0> (192.168.65.1:39528 -> 172.17.0.2:5672)
    2024-01-14 06:19:07.087994+00:00 [info] <0.717.0> connection <0.717.0> (192.168.65.1:39528 -> 172.17.0.2:5672): user 'guest' authenticated and granted access to vhost '/'
    2024-01-14 06:19:07.090848+00:00 [info] <0.717.0> closing AMQP connection <0.717.0> (192.168.65.1:39528 -> 172.17.0.2:5672, vhost: '/', user: 'guest')
    2024-01-14 06:19:12.373633+00:00 [info] <0.737.0> accepting AMQP connection <0.737.0> (192.168.65.1:39529 -> 172.17.0.2:5672)
    2024-01-14 06:19:12.378652+00:00 [info] <0.737.0> connection <0.737.0> (192.168.65.1:39529 -> 172.17.0.2:5672): user 'guest' authenticated and granted access to vhost '/'
    2024-01-14 06:19:12.381346+00:00 [info] <0.737.0> closing AMQP connection <0.737.0> (192.168.65.1:39529 -> 172.17.0.2:5672, vhost: '/', user: 'guest')
    2024-01-14 06:19:17.281427+00:00 [info] <0.754.0> accepting AMQP connection <0.754.0> (192.168.65.1:39535 -> 172.17.0.2:5672)
    2024-01-14 06:19:17.287374+00:00 [info] <0.754.0> connection <0.754.0> (192.168.65.1:39535 -> 172.17.0.2:5672): user 'guest' authenticated and granted access to vhost '/'
    2024-01-14 06:19:17.289706+00:00 [info] <0.754.0> closing AMQP connection <0.754.0> (192.168.65.1:39535 -> 172.17.0.2:5672, vhost: '/', user: 'guest')
    2024-01-14 06:19:17.292364+00:00 [info] <0.679.0> closing AMQP connection <0.679.0> (192.168.65.1:39507 -> 172.17.0.2:5672, vhost: '/', user: 'guest')
    ...

## Credits and References

* [amqp - rubygems](https://rubygems.org/gems/amqp)
* [amqp - GitHub](https://github.com/ruby-amqp/amqp)
