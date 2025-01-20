# #136 Using InfluxDb 2.x with Ruby

Testing out the official ruby client calling a InfluxDb 2.0.0-beta server running in Docker.

## Notes

The official [influxdb-client-ruby](https://github.com/influxdata/influxdb-client-ruby) gem has been released to support InfluxDb 2.x.
This test is running with InfluxDb 2.0.0-beta.

### Installing Ruby Gems

The Gemfile is setup for bundler:

    $ gem install bundler
    $ bundle install

At the time or writing, this isntalls v1.1.0 of the influxdb-client-ruby gem.

### Running InfluxDb in Docker

I'm using a Dockerized version of InfluxDb 2.0.0-beta for testing:

```
$ ../about/influx_control.sh start
Stopping/removing any previous docker container..
myinfluxdb
myinfluxdb
Starting  container with web access on port 9999..
c701849eecda6715baa45d1c8ee6286e81328b22bfaf633af66ede45e2227d71
```

### Overview of the InfluxDb2 gem

The official [influxdb-client-ruby](https://github.com/influxdata/influxdb-client-ruby) gem is very new and still subject to some basic bug fixes.
The InflusDb v2 API documented following [OpenAPI (previously known as swagger)](https://en.wikipedia.org/wiki/OpenAPI_Specification) guidelines,
and [OpenAPI Generator](https://openapi-generator.tech/) is used to generate the underlying models in the gem.

I would summarize the gem's capabilities as follows (with the caveat that my exposure to the gem is still quite limited):

* it is focused on solving the flux query and result structure handling, so capabilities are currently limited to write, query and delete data.
* it does not provide direct support for setup and management commands, though arguably these are trivially handled with direct Net:HTTP or RestClient requests.
* it is (intentionally?) not very idiomatic:
  * queries must be made in Flux syntax. The gem takes care of the hard work of creating a valid [query](https://v2.docs.influxdata.com/v2.0/api/#operation/PostQuery)
  * results are presented as `FluxTable` / `FluxColumn` / `FluxRecord` objects that must be further processed to be compatible with the typical end-use of the query.
* Some improvements it would be nice to see in the gem:
  * an option to present results in basic ruby data types (array of hashes or array of arrays) to make it simpler for gluing together the results of InfluxDb queries typically applications such as ActiveRecord updates or streaming data out via a RESTful Rails API
  * take care of some annoying usability issues such as needing to `use_ssl: false` when that could/should be implied by the protocol in the URI provided


### Stream Some Data

For some random data, I'm using the `w` command, that includes some processor stats in line 1:

```
$ w | head -1
23:21  up 18 days, 21:48, 15 users, load averages: 2.82 2.93 2.83
```

The `stream_stats.rb` example posts load averages every 5 seconds to a series called `lck_cpu`
with a `series` tag indicating past 1, 5, and 15 minute averages.

By default, the script sends the data in [line protocol](https://v2.docs.influxdata.com/v2.0/reference/syntax/line-protocol/) format,
but it also demonstrates sending in hash and point format (selected with a command line parameter).

```
$ bundle exec ./stream_stats.rb
Streaming some stats to bucket:demo1 every 5 seconds..
Posting [2.51, 2.55, 2.56] at 1583400081000000000..
["lck_cpu,series=past1 utilization=2.51 1583400081000000000", "lck_cpu,series=past5 utilization=2.55 1583400081000000000", "lck_cpu,series=past15 utilization=2.56 1583400081000000000"]
Posting [2.63, 2.57, 2.56] at 1583400086000000000..
["lck_cpu,series=past1 utilization=2.63 1583400086000000000", "lck_cpu,series=past5 utilization=2.57 1583400086000000000", "lck_cpu,series=past15 utilization=2.56 1583400086000000000"]
...
```

Streaming in hash format:

```
$ bundle exec ./stream_stats.rb hash
Streaming some stats to bucket:demo1 every 5 seconds..
Posting [2.82, 2.61, 2.58] at 1583400092000000000..
[{:name=>"lck_cpu", :tags=>{:series=>"past1"}, :fields=>{:utilization=>2.82}, :time=>1583400092000000000}, {:name=>"lck_cpu", :tags=>{:series=>"past5"}, :fields=>{:utilization=>2.61}, :time=>1583400092000000000}, {:name=>"lck_cpu", :tags=>{:series=>"past15"}, :fields=>{:utilization=>2.58}, :time=>1583400092000000000}]
Posting [2.75, 2.6, 2.57] at 1583400097000000000..
[{:name=>"lck_cpu", :tags=>{:series=>"past1"}, :fields=>{:utilization=>2.75}, :time=>1583400097000000000}, {:name=>"lck_cpu", :tags=>{:series=>"past5"}, :fields=>{:utilization=>2.6}, :time=>1583400097000000000}, {:name=>"lck_cpu", :tags=>{:series=>"past15"}, :fields=>{:utilization=>2.57}, :time=>1583400097000000000}]
...
```

Streaming in point format:

```
$ bundle exec ./stream_stats.rb point
Streaming some stats to bucket:demo1 every 5 seconds..
Posting [2.93, 2.64, 2.59] at 1583400102000000000..
[#<InfluxDB2::Point:0x00007f90950ecba8 @name="lck_cpu", @tags={"series"=>"past1"}, @fields={"utilization"=>2.93}, @time=1583400102000000000, @precision="ns">, #<InfluxDB2::Point:0x00007f90950ec4c8 @name="lck_cpu", @tags={"series"=>"past5"}, @fields={"utilization"=>2.64}, @time=1583400102000000000, @precision="ns">, #<InfluxDB2::Point:0x00007f90950e7bf8 @name="lck_cpu", @tags={"series"=>"past15"}, @fields={"utilization"=>2.59}, @time=1583400102000000000, @precision="ns">]
Posting [3.02, 2.66, 2.6] at 1583400107000000000..
[#<InfluxDB2::Point:0x00007f90950b7930 @name="lck_cpu", @tags={"series"=>"past1"}, @fields={"utilization"=>3.02}, @time=1583400107000000000, @precision="ns">, #<InfluxDB2::Point:0x00007f90950b74f8 @name="lck_cpu", @tags={"series"=>"past5"}, @fields={"utilization"=>2.66}, @time=1583400107000000000, @precision="ns">, #<InfluxDB2::Point:0x00007f90950b7110 @name="lck_cpu", @tags={"series"=>"past15"}, @fields={"utilization"=>2.6}, @time=1583400107000000000, @precision="ns">]
...
```

The Data Explorer is a really nice new feature of InfluxDb2. Here's how the data looks as it streams in:

![lck_cpu_in_the_data_explorer](./assets/lck_cpu_in_the_data_explorer.png?raw=true)

### Query Data

The `query_stats.rb` example queries the most recent data points for the `lck_cpu` measurement.
[Flux](https://v2.docs.influxdata.com/v2.0/reference/syntax/flux/) data structures are not deconstructed for printing:

```
$ bundle exec ./query_stats.rb
Querying the most recent lck_cpu stats from bucket:demo1..

Record: 0
#<InfluxDB2::FluxColumn:0x00007fcfe5968db0 @index=0, @label="result", @data_type="string", @group=false, @default_value="_result">
#<InfluxDB2::FluxColumn:0x00007fcfe5968b30 @index=1, @label="table", @data_type="long", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968a90 @index=2, @label="_start", @data_type="dateTime:RFC3339", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968a18 @index=3, @label="_stop", @data_type="dateTime:RFC3339", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968838 @index=4, @label="_time", @data_type="dateTime:RFC3339", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe59685b8 @index=5, @label="_value", @data_type="double", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968478 @index=6, @label="_field", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968310 @index=7, @label="_measurement", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968108 @index=8, @label="series", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxRecord:0x00007fcfe595aeb8 @table=0, @values={"result"=>nil, "table"=>0, "_start"=>"1970-01-01T00:00:00+00:00", "_stop"=>"2020-03-05T11:06:29+00:00", "_time"=>"2020-03-05T09:21:47+00:00", "_value"=>3.02, "_field"=>"utilization", "_measurement"=>"lck_cpu", "series"=>"past1"}>

Record: 1
#<InfluxDB2::FluxColumn:0x00007fcfe5968db0 @index=0, @label="result", @data_type="string", @group=false, @default_value="_result">
#<InfluxDB2::FluxColumn:0x00007fcfe5968b30 @index=1, @label="table", @data_type="long", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968a90 @index=2, @label="_start", @data_type="dateTime:RFC3339", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968a18 @index=3, @label="_stop", @data_type="dateTime:RFC3339", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968838 @index=4, @label="_time", @data_type="dateTime:RFC3339", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe59685b8 @index=5, @label="_value", @data_type="double", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968478 @index=6, @label="_field", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968310 @index=7, @label="_measurement", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968108 @index=8, @label="series", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxRecord:0x00007fcfe5949fc8 @table=1, @values={"result"=>nil, "table"=>1, "_start"=>"1970-01-01T00:00:00+00:00", "_stop"=>"2020-03-05T11:06:29+00:00", "_time"=>"2020-03-05T09:21:47+00:00", "_value"=>2.6, "_field"=>"utilization", "_measurement"=>"lck_cpu", "series"=>"past15"}>

Record: 2
#<InfluxDB2::FluxColumn:0x00007fcfe5968db0 @index=0, @label="result", @data_type="string", @group=false, @default_value="_result">
#<InfluxDB2::FluxColumn:0x00007fcfe5968b30 @index=1, @label="table", @data_type="long", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968a90 @index=2, @label="_start", @data_type="dateTime:RFC3339", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968a18 @index=3, @label="_stop", @data_type="dateTime:RFC3339", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968838 @index=4, @label="_time", @data_type="dateTime:RFC3339", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe59685b8 @index=5, @label="_value", @data_type="double", @group=false, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968478 @index=6, @label="_field", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968310 @index=7, @label="_measurement", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxColumn:0x00007fcfe5968108 @index=8, @label="series", @data_type="string", @group=true, @default_value=nil>
#<InfluxDB2::FluxRecord:0x00007fcfe5942598 @table=2, @values={"result"=>nil, "table"=>2, "_start"=>"1970-01-01T00:00:00+00:00", "_stop"=>"2020-03-05T11:06:29+00:00", "_time"=>"2020-03-05T09:21:47+00:00", "_value"=>2.66, "_field"=>"utilization", "_measurement"=>"lck_cpu", "series"=>"past5"}>
```

## Credits and References

* [influxdb-client-ruby](https://github.com/influxdata/influxdb-client-ruby) - sources
* [influxdb v2 API docs](https://v2.docs.influxdata.com/v2.0/api/)
* [line protocol](https://v2.docs.influxdata.com/v2.0/reference/syntax/line-protocol/)
* [Flux syntax](https://v2.docs.influxdata.com/v2.0/reference/syntax/flux/)
* [man w](https://linux.die.net/man/1/w)
