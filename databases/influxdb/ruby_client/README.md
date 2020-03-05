# Using InfluxDb 1.x with Ruby

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

### Stream Some Data

For some random data, I'm using the `w` command, that includes some processor stats in line 1:

```
$ w | head -1
23:21  up 18 days, 21:48, 15 users, load averages: 2.82 2.93 2.83
```

The `stream_stats.rb` example posts load averages every 5 seconds to a series called `cpu`
with a `bucket` tag indicating past 1, 5, and 15 minute averages, so each data point will be like this:

```
{
  series: 'cpu',
  tags: { bucket: 'past1' },
  values: { load: 2.56 },
  timestamp: 1578414170
}
```

Running the stream...

```
$ ./stream_stats.rb
Streaming some stats to database:demo1 every 5 seconds..
...
Posting [2.01, 2.57, 2.62] at 1578417712..
Posting [2.17, 2.6, 2.63] at 1578417717..
Posting [2.23, 2.6, 2.63] at 1578417722..
Posting [2.13, 2.58, 2.62] at 1578417727..
Posting [2.04, 2.55, 2.61] at 1578417732..
Posting [2.04, 2.54, 2.6] at 1578417737..
Posting [2.2, 2.57, 2.61] at 1578417742..
```

### Query Data

Doing a simple query for the last 6 points (`select * from cpu WHERE bucket = 'past1' ORDER BY time DESC LIMIT 6`)..

```
$ ./query_stats.rb
Querying the most recent cpu,bucket=past1 stats from database:demo1..
{"time"=>"2020-01-07T17:22:22Z", "bucket"=>"past1", "load"=>2.2}
{"time"=>"2020-01-07T17:22:17Z", "bucket"=>"past1", "load"=>2.04}
{"time"=>"2020-01-07T17:22:12Z", "bucket"=>"past1", "load"=>2.04}
{"time"=>"2020-01-07T17:22:07Z", "bucket"=>"past1", "load"=>2.13}
{"time"=>"2020-01-07T17:22:02Z", "bucket"=>"past1", "load"=>2.23}
{"time"=>"2020-01-07T17:21:57Z", "bucket"=>"past1", "load"=>2.17}
```

## Credits and References

* [influxdb-ruby](https://github.com/influxdata/influxdb-ruby) - sources
* [influxdb-ruby](https://www.rubydoc.info/gems/influxdb/0.1.9) - help
* [influxdb Docker Official Images](https://hub.docker.com/_/influxdb)
* [influxdb 1.7 docs](https://docs.influxdata.com/influxdb/v1.7)
* [man w](https://linux.die.net/man/1/w)
