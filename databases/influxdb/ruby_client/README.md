# Using InfluxDb with Ruby

Testing out the official ruby client calling a InfluxDb 1.7.9 server running in Docker.

## Notes

The official [influxdb-ruby](https://github.com/influxdata/influxdb-ruby) gem does not support InfluxDb 2.x (yet?),
so this test is running with InfluxDb 1.7.9.

### Installing Ruby Gems

The Gemfile is setup for bundler:

    $ gem install bundler
    $ bundle install

### Running InfluxDb in Docker

I'm using a Dockerized version of InfluxDb 1.7.9 for testing:

```
$ ./influx_control.sh start
Stopping/removing any previous docker container..
Error response from daemon: No such container: myinfluxdb17
Error: No such container: myinfluxdb17
Starting  container with web access on port 8086..
5ae110ac836fa4123af6c249aa85e8812d43879e980d543f4c96e86e5ff6cc4d
```

### Exercising the Ruby Client

Creating a database:

```
$ ./create_database.rb
Creating database demo1..
Adding user admin/password..
```

```
$ ./list_databases.rb
List databases..
{"name"=>"_internal"}
{"name"=>"demo1"}
```


### Steam Some Data

For some random data, I'm using the `w` command, that includes some processor stats in line 1:

```
$ w | head -1
23:21  up 18 days, 21:48, 15 users, load averages: 2.82 2.93 2.83
```

The `stream_stats.rb` example posts load averages every 5 seconds to a series called `cpu`
with an `instance` tag naming the core, so each data point will be like this:

```
{
  series: 'cpu',
  tags: { instance: 'core-2' },
  values: { load: 2.56 },
  timestamp: 1578414170
}
```

Running the stream...

```
$ ./stream_stats.rb
...
Posting [2.24, 2.57, 2.56] at 1578414170..
Posting [2.14, 2.54, 2.55] at 1578414175..
Posting [2.05, 2.52, 2.54] at 1578414180..
Posting [2.6, 2.62, 2.58] at 1578414185..
Posting [2.55, 2.61, 2.58] at 1578414190..
Posting [2.43, 2.59, 2.57] at 1578414195..
Posting [2.56, 2.61, 2.58] at 1578414200..
...
```

Doing a simple query for the last 6 points (`select * from cpu WHERE instance = 'core-0' ORDER BY time DESC LIMIT 6`)..

```
$ ./query_stats.rb
Querying the most recent cpu:core-0 stats from database:demo1..
{"time"=>"2020-01-07T16:23:20Z", "instance"=>"core-0", "load"=>2.56}
{"time"=>"2020-01-07T16:23:15Z", "instance"=>"core-0", "load"=>2.43}
{"time"=>"2020-01-07T16:23:10Z", "instance"=>"core-0", "load"=>2.55}
{"time"=>"2020-01-07T16:23:05Z", "instance"=>"core-0", "load"=>2.6}
{"time"=>"2020-01-07T16:23:00Z", "instance"=>"core-0", "load"=>2.05}
{"time"=>"2020-01-07T16:22:55Z", "instance"=>"core-0", "load"=>2.14}
```

## Credits and References

* [influxdb-ruby](https://github.com/influxdata/influxdb-ruby) - sources
* [influxdb-ruby](https://www.rubydoc.info/gems/influxdb/0.1.9) - help
* [influxdb Docker Official Images](https://hub.docker.com/_/influxdb)
* [influxdb 1.7 docs](https://docs.influxdata.com/influxdb/v1.7)
